(async () => {
  while (!Spicetify.React || !Spicetify.ReactDOM)
    await new Promise(e => setTimeout(e, 10));
  (async () => {
    while ((null === Spicetify || !Spicetify.showNotification) && Spicetify)
      await new Promise(e => setTimeout(e, 100));
    const i = await (() => {
      let t;
      return new Promise((r, o) => {
        var e = indexedDB.open("SpicetifyHistoryDB", 1);
        (e.onerror = e => {
          var r =
            (null === (r = e.target.error) ? void 0 : r.message) ||
            "Unknown error";
          console.error("Database error:", e.target.error), o(r);
        }),
          (e.onsuccess = e => {
            (t = e.target.result),
              console.log("Database opened successfully"),
              r(t);
          }),
          (e.onupgradeneeded = e => {
            var e = e.target.result;
            e.objectStoreNames.contains("history") ||
              ((e = e.createObjectStore("history", {
                keyPath: "uid",
              })).createIndex("name", "name", { unique: !1 }),
              e.createIndex("uri", "uri", { unique: !0 }),
              e.createIndex("listenDate", "listenDate", { unique: !1 }),
              console.log("Object store 'history' created"));
          });
      });
    })();
    let s;
    Spicetify.Player.addEventListener("songchange", async () => {
      var e;
      var r;
      var a;
      var o = null === (o = Spicetify.Player.data) ? void 0 : o.item;
      if (o && "track" === o.type) {
        var t =
          (null === (t = o.artists)
            ? void 0
            : t.map(e => ({ name: e.name, uri: e.uri }))) || [];
        var n =
          (null === (n = o.images)
            ? void 0
            : n.map(e => ({ label: e.label, url: e.url }))) || [];
        s = {
          uid: o.uid,
          uri: o.uri,
          name: o.name,
          duration: o.duration,
          album: {
            uri: null === (e = o.album) ? void 0 : e.uri,
            name: null === (e = o.album) ? void 0 : e.name,
          },
          artists: t,
          metadata: o.metadata,
          images: n,
          listenDate: new Date().getTime(),
        };
        try {
          (r = i),
            (a = s),
            await new Promise((o, t) => {
              const n = r
                .transaction(["history"], "readwrite")
                .objectStore("history");
              var e = n.index("uri").get(a.uri);
              (e.onerror = e => {
                e =
                  (null === (e = e.target.error) ? void 0 : e.message) ||
                  "Unknown error";
                console.error("Error retrieving song by uri:", e), t(e);
              }),
                (e.onsuccess = e => {
                  const r = e.target.result;
                  r
                    ? (console.log(`Song found in index for uri ${a.uri}:`, r),
                      (r.listenDate = a.listenDate),
                      ((e = n.put(r)).onerror = e => {
                        e =
                          (null === (e = e.target.error)
                            ? void 0
                            : e.message) || "Unknown error";
                        console.error("Error updating song:", e), t(e);
                      }),
                      (e.onsuccess = () => {
                        console.log("Song listenDate updated:", r.name), o();
                      }))
                    : (((e = n.add(a)).onerror = e => {
                        e =
                          (null === (e = e.target.error)
                            ? void 0
                            : e.message) || "Unknown error";
                        console.error("Error saving song:", e), t(e);
                      }),
                      (e.onsuccess = () => {
                        console.log("Song added to IndexedDB:", a.name), o();
                      }));
                });
            }),
            console.log("Song saved:", s.name);
        } catch (e) {
          console.error("Failed to save song:", e);
        }
      }
    });
  })();
})();
