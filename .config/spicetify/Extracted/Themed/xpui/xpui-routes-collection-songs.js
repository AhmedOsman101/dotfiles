"use strict";(("undefined"!=typeof self?self:global).webpackChunkclient_web=("undefined"!=typeof self?self:global).webpackChunkclient_web||[]).push([[8828],{29425:(e,t,l)=>{l.d(t,{s:()=>y});var a=l(30758),r=l(97500),s=l.n(r),i=l(96613),n=l(75308),o=l(23530),c=l(27054);const d="IVnoxrO3iL_tz5ULI8g_";var u=l(86070);const g={marginBlockEnd:0,willChange:"transform, opacity"},m=({filterId:e=null,isPrimaryFilter:t,isPlaceholder:l,resetFilterIds:r,toggleFilterId:n,className:o,innerRef:c,onFilterClick:m,index:p=0,...y})=>{const f=y.selected,h=(0,a.useCallback)((()=>{if(!e)return r(),void m(null,!1,p);m(e,!!f,p),n(e)}),[e,r,n,m,f,p]),x=(0,a.useCallback)((e=>{e.detail>1||l||h()}),[l,h]);return(0,u.jsx)(i.v,{...y,className:s()(o,{[d]:l}),onClick:x,selectedColorSet:"invertedLight",secondary:f&&!t,style:g,ref:c,tabIndex:-1})},p=({filterId:e=null,isPlaceholder:t,resetFilterIds:l,toggleFilterId:r,className:i,innerRef:o,onFilterClick:c,index:m=0,...p})=>{const y=p.selected,f=(0,a.useCallback)((()=>{if(!e)return l(),void c(null,!1,m);c(e,!!y,m),r(e)}),[e,l,r,c,y,m]),h=(0,a.useCallback)((e=>{e.detail>1||t||f()}),[t,f]);return(0,u.jsx)(n.m,{...p,"aria-label":p["aria-label"],className:s()(i,{[d]:t}),onClick:h,style:g,ref:o,tabIndex:-1})},y=(0,a.memo)((function({placeholderFilters:e=[],availableFilters:t,selectedFilters:l,toggleFilterId:r,resetFilterIds:s,onFilterClick:i,ariaLabel:n,clearBtnAriaLabel:d,className:g,applyLightThemeControls:y=!1}){const f=!(l||t),h=f?e:[...l??[],...t??[]],x=(0,a.useRef)(null),k=(0,a.useCallback)((()=>{(0,c.MS)(x.current,x.current?.nextElementSibling instanceof HTMLElement?x.current?.nextElementSibling:null),s()}),[s]);return 0===h.length?null:(0,u.jsxs)(o.FN,{className:g,ariaLabel:n,applyLightThemeControls:y,children:[!!l?.length&&(0,u.jsx)(p,{resetFilterIds:k,toggleFilterId:r,onFilterClick:i,"aria-label":d??n,innerRef:x}),h.map(((e,t)=>{const a=l?.includes(e),n=0===t;return(0,u.jsx)(m,{filterId:e.id,isPrimaryFilter:n,isPlaceholder:f,onFilterClick:i,resetFilterIds:s,toggleFilterId:r,selected:a,index:t,children:e.getName()},e.id)}))]})}))},1335:(e,t,l)=>{l.d(t,{g:()=>E});var a=l(30758),r=l(3074),s=l.n(r),i=l(56570),n=l(92441),o=l(6128),c=l(63166),d=l(11846),u=l(44979),g=l(29213),m=l(85834),p=l(99903),y=l(1127),f=l(12433),h=l(89865),x=l(64721),k=l(41617),b=l(67579),C=l(86070);const S=({onSelect:e})=>{const{viewMode:t,setViewMode:l}=(0,k.a)();return(0,C.jsxs)(C.Fragment,{children:[(0,C.jsx)(y.y,{children:x.Ru.get("web-player.your-library-x.sort-and-view-picker.view-as")}),b.i.map((({value:a,icon:r,text:s},i)=>(0,C.jsx)(f.D,{role:"menuitemradio","aria-checked":t===a,divider:i===b.i.length-1?"after":void 0,autoClose:!1,leadingIcon:r(),onClick:()=>{l(a),e?.(a)},children:s()},a)))]})},T=({heading:e,selected:t,onSelect:l,options:a,enableViewModeMenu:r=!1,onSelectViewMode:s,sortOrder:i,...n})=>{let o;i&&(i===h.H.ASC||i===h.H.SECONDARY_ASC?o=g.U:i!==h.H.DESC&&i!==h.H.SECONDARY_DESC||(o=m.R));return(0,C.jsxs)(p.W,{getInitialFocusElement:e=>e?.querySelector('[aria-checked="true"]'),...n,children:[e?(0,C.jsx)(y.y,{children:e}):null,a.map((({key:e,value:a},r)=>(0,C.jsx)(f.D,{role:"menuitemradio","aria-checked":e===t.key,CheckedIcon:o,onClick:()=>l(e,r),children:a},e))),r&&(0,C.jsx)(S,{onSelect:s})]})};var I=l(30164),A=l(1620),F=l(27602);const j="x-sortBox-sortDropdown",w="cvTLPmjt6T7M85EKcB8w",D="SbDHY3fVADNJ4l9qOLQ2",R=({isOpen:e,className:t})=>e?(0,C.jsx)(i.J,{size:"small","aria-hidden":"true",className:t}):(0,C.jsx)(n.y,{size:"small","aria-hidden":"true",className:t}),E=({heading:e,options:t,selected:l,onSelect:r,sortOrder:i,variant:n="bodySmall",semanticColor:g,disabled:m,onClick:p,ariaLabel:y,enableViewModeMenu:f=!1})=>{const h=(0,c.NC)(F.mA)&&f,{viewMode:x}=(0,I.a)();l||(l=t?.[0]);const k=b.i.find((({value:e})=>e===x))||b.i[0],S=(0,a.useMemo)((()=>`sortboxlist-${s().create().hex}`),[]),{spec:E,logger:v}=(0,A.r)(d.d,{});return(0,C.jsx)(u.b,{menu:(0,C.jsx)(T,{selected:l,options:t,onSelect:(e,t)=>{r(e,t);const l=E.sortBySectionFactory().sortOptionFactory({identifier:e}).hitSort();v.logInteraction(l)},sortOrder:i,heading:e,enableViewModeMenu:h,onSelectViewMode:e=>{const t=E.viewAsSectionFactory().viewOptionFactory({identifier:e}).hitUiElementToggle();v.logInteraction(t)},id:S}),children:(e,t,a)=>(0,C.jsxs)("button",{className:j,onClick:e=>{m||(p?.(e),t(e))},ref:a,type:"button","aria-label":y,role:"combobox","aria-controls":S,"aria-expanded":e,children:[(0,C.jsx)(o.E,{"data-sortbox-label":!0,semanticColor:g,variant:n,className:w,children:l?.value||(h?k.text():"")}),h?k.icon():(0,C.jsx)(R,{isOpen:e,className:D})]})})}},20154:(e,t,l)=>{l.d(t,{b:()=>T});var a=l(30758),r=l(64721),s=l(86399),i=l(56829),n=l(78358),o=l(66207),c=l(48586),d=l(32356),u=l(23617),g=l(98486),m=l(89865),p=l(89662),y=l(95309),f=l(39733),h=l(11716),x=l(10058),k=l(74971),b=l(86070);const C=new Set(o.gc),S=new Set([]),T=a.memo((function({nrTracks:e,collectionUri:t,initialItems:l,uri:T,sortable:I=!0,scrollToUri:A,usePlayContextItem:F,outerDomRef:j,spec:w,isCompactMode:D=!1,tagFilter:R}){const E=(0,f.f)(),v=(0,a.useRef)(null),{filter:P}=(0,a.useContext)(n.g),L=(0,a.useRef)((()=>{})),[M,_]=(0,a.useState)([]),{sortState:N,setSortState:O}=(0,a.useContext)(o.cL),U=(0,h.s)(),B=(0,c.w)(),$=(0,a.useCallback)(((e,t)=>{e===m.$.ADDED_AT?O({column:m.$.ADDED_AT,order:N.order===m.H.ASC?m.H.DESC:m.H.ASC}):O((0,s.So)(e,N)),w&&U.logInteraction(w.columnHeaderFactory({identifier:e,position:t||0}).hitSort())}),[U,O,N,w]);(0,a.useEffect)((()=>{v.current&&A&&v.current.scrollToItem({uri:A})}),[A]);const V=(0,a.useCallback)((e=>{const t=e.map((e=>e.uri));L.current(),E.remove({uris:t})}),[E]),H=(0,a.useCallback)(((e,t)=>{L.current=t,e.length>1?_(e):V(e)}),[V]),[,z]=(0,d.z1)(),K=(0,a.useCallback)((async(e,t)=>{const l=await E.getTracks({offset:e,limit:t,uri:T,sort:(0,p.c)(N),filters:[P??null,R??null].filter(x.P)}),a=l?.totalLength??0;return{items:l?.items??[],totalLength:a}}),[P,R,E,N,T]),q=(0,a.useCallback)(((e,l)=>{const a=(0,k.g)(e.album?.images,{desiredSize:40,desiredLabel:"small"});return(0,b.jsx)(u.W,{index:l,contextUri:t,uri:e.uri,isPlayable:e.isPlayable,duration_ms:e.duration.milliseconds,name:e.name,artists:e.artists,albumOrShow:e.album,isExplicit:e.isExplicit,isMixedMedia:!1,isPaywalled:!1,isUserSubscribed:!1,isLocal:e.isLocal,addedBy:[],dateAdded:e.addedAt,hasDecoratedAddedBy:!1,release_date:"",isMOGEFRestricted:e.is19PlusOnly,type:e.type,imgUrl:a?.url||"",onMove:()=>{},onInsert:()=>{},usePlayContextItem:F,allowedDropTypes:[],isDisliked:!1,playlistName:r.Ru.get("sidebar.liked_songs"),isOwnedBySelf:!0,isCompactMode:D,hasAssociatedVideo:e.hasAssociatedVideo},l+e.uri)}),[t,F,D]),X=(0,a.useCallback)((e=>({uri:e.uri,uid:e.uri})),[]);return(0,b.jsxs)(b.Fragment,{children:[(0,b.jsx)(y.pZ,{value:"liked-songs-tracklist",children:(0,b.jsx)(g.S4,{ariaLabel:r.Ru.get("sidebar.liked_songs"),hasHeaderRow:!0,columns:B,sortableColumns:E.getCapabilities().canSortTracksAndEpisodes&&I?C:S,sortState:N,onSort:$,renderRow:q,resolveItem:X,onRemove:H,nrTracks:e,fetchTracks:K,limit:50,canFetchAllTracks:E.getCapabilities().canFetchAllItems,outerRef:v,outerDomRef:j,tracks:l,onNrValidItemsChange:z,isCompactMode:D,columnPersistenceKey:"liked-songs-tracklist"},t)}),(0,b.jsx)(i.F,{title:r.Ru.get("remove_from_your_liked_songs"),isOpen:M.length>0,tracks:M,onClose:e=>{e.stopPropagation(),_([])},onRemove:V})]})}))},89662:(e,t,l)=>{l.d(t,{c:()=>n});var a=l(86399),r=l(61656),s=l(19240);const i={[s.nw.ADDED_AT]:r.Sw.ADDED_AT,[s.nw.ADDED_BY]:null,[s.nw.ALBUM]:r.Sw.ALBUM_NAME,[s.nw.ARTIST]:r.Sw.ARTIST_NAME,[s.nw.DURATION]:null,[s.nw.TITLE]:r.Sw.NAME,[s.nw.SHOW_NAME]:null,[s.nw.PUBLISH_DATE]:null},n=e=>{const t=(0,a.Xt)(e);if(!t)return;const l=i[t.field],r=t.order;return l&&r?{field:l,order:r}:void 0}},90651:(e,t,l)=>{l.r(t),l.d(t,{default:()=>Ve});var a=l(30758),r=l(95440),s=l(1978),i=l(68560),n=l(63166),o=l(3426),c=l(75627),d=l(64721),u=l(18212),g=l(30494),m=l(9498),p=l(78358),y=l(66207),f=l(32356),h=l(19703),x=l(89865),k=l(69319),b=l(16683),C=l(60007),S=l(97152),T=l(29294),I=l(1335),A=l(35067),F=l(11717),j=l(67756),w=l(48586),D=l(1620),R=l(37481),E=l(86070);const v=a.memo((({tracklistDomRef:e})=>{const{spec:t,logger:l}=(0,D.r)(A.E,{}),r=(0,a.useCallback)((()=>{l.logInteraction(t.filterFieldFactory().keyStrokeFilter())}),[l,t]),s=(0,a.useCallback)((()=>{l.logInteraction(t.filterFieldFactory().hitClearFilter())}),[l,t]),i=(0,w.w)().filter((({columnType:e})=>y.gc.includes(e))).map((({columnType:e})=>e));return(0,E.jsxs)("div",{className:R.A.searchBoxContainer,children:[(0,E.jsx)(a.Suspense,{fallback:null,children:(0,E.jsx)(F.S,{placeholder:d.Ru.get("playlist.search_in_playlist"),clearOnEscapeInElementRef:e,onFilter:r,onClear:s})}),(0,E.jsx)(j.d,{columns:i})]})}));var P=l(97500),L=l.n(P),M=l(29425),_=l(34889),N=l(15758),O=l(72509),U=l(19412),B=l(79365),$=l(39733),V=l(87285),H=l(76698);const z="liked-songs-tags";function K(){const e=(0,n.NC)(U.cLA),[t,l]=(0,H.x)("liked-songs-current-tag-filter",null);return[e?t:null,l]}var q=l(11716);const X="q_yjkS1y6URH4Xm7gZfw",Q=e=>({id:e.filter,getName:()=>e.name,ubiId:e.name}),W=(0,a.memo)((({spec:e,nrTracks:t})=>{const{tags:l,currentTag:r,setCurrentTag:s}=function({nrTracks:e}){const t=(0,$.f)(),l=(0,_.jE)(),[r,s]=K(),[i,n]=(0,a.useState)([]),{data:o}=(0,N.I)({queryKey:[z],queryFn:()=>t?.getTracksFilterTags(),staleTime:0,gcTime:864e5,placeholderData:O.rX,refetchOnWindowFocus:!1});(0,a.useLayoutEffect)((()=>{const t=o?.find((e=>e.filter===r));if(!t&&r){if(e>0&&o?.length)return;s(null)}n(o??[])}),[r,s,e,o]);const c=(0,a.useCallback)((({data:{list:e}})=>{e===B.Ir.TRACKS&&l.invalidateQueries({queryKey:[z]})}),[l]);(0,V.l)(B.UV.UPDATE,c);const d=(0,a.useMemo)((()=>i.find((e=>e.filter===r))),[r,i]),u=(0,a.useCallback)((e=>{s(e?.filter??null)}),[s]);return{tags:r||e?i:[],currentTag:d,setCurrentTag:u}}({nrTracks:t}),i=(0,q.s)(),n=(0,a.useCallback)(((t,a,r)=>{let n;if(!t)return n=e.clearButtonFactory().hitClearFilter(),void i.logInteraction(n);const o=l.find((({filter:e})=>e===t));if(!o)return;const c=e.filterChipFactory({identifier:o.name,position:r});a?(n=c.hitClearFilter(),s(null)):(n=c.hitFilter(),o&&s(o)),i.logInteraction(n)}),[i,s,e,l]),o=r?[]:l.map(Q),c=r?[Q(r)]:[];return l.length?(0,E.jsx)(b.S,{children:(0,E.jsx)(M.s,{availableFilters:o,selectedFilters:c,toggleFilterId:()=>{},resetFilterIds:()=>s(null),onFilterClick:n,ariaLabel:d.Ru.get("web-player.liked-songs.liked-songs-filter-tags"),clearBtnAriaLabel:d.Ru.get("web-player.liked-songs.clear-filter"),className:L()(X),applyLightThemeControls:!0})}):null}));var Y=l(81719),Z=l(29434),J=l(17566),G=l(49811),ee=l(56106),te=l(19240),le=l(63112),ae=l(27602);const re="ivuDaTbfBpBewwr39aDQ",se=a.memo((function({metadata:e,onClickTogglePlay:t,isPlaying:l,spec:r,logger:s,backgroundColor:i,canSort:o,canFilter:c}){const{uri:u,name:g,totalLength:m}=e,p=(0,a.useRef)(null),y=(0,a.useMemo)((()=>r.actionBarFactory()),[r]),f=(0,a.useMemo)((()=>y.shuffleButtonContainerFactory()),[y]),h=(0,a.useMemo)((()=>y.filtersFactory()),[y]),x=m>0,A=m>0,F=o&&c,j=(0,J.X)(),w=(0,a.useCallback)(((e,t)=>{const l=y.downloadButtonFactory();t===ee.NV.ADD?s.logInteraction(l.hitDownload({itemToDownload:u})):t===ee.NV.REMOVE?s.logInteraction(l.hitRemoveDownload({itemToRemoveFromDownloads:u})):t===ee.NV.NO_PERMISSION&&s.logInteraction(l.hitUiReveal())}),[y,s,u]),D=(0,G.j)(),R=(0,n.NC)(U.cLA);return(0,E.jsxs)(k.E,{backgroundColor:i,children:[(0,E.jsxs)(b.S,{children:[A?(0,E.jsx)(T.D,{onClick:t,isPlaying:l,size:D,uri:u,ariaPauseLabel:d.Ru.get("playlist.a11y.pause",g),ariaPlayLabel:d.Ru.get("playlist.a11y.play",g)}):null,j&&(0,E.jsx)(le.r,{spec:f,children:(0,E.jsx)(Z.Y,{entityName:g,contextUri:u,activationPlacement:"bottomEnd",size:D})}),(0,E.jsx)(C.f,{uri:u,canDownload:x,isFollowing:!0,onFollow:()=>{},size:D,onClick:w,condensed:!0}),F?(0,E.jsx)(le.r,{spec:y,children:(0,E.jsx)(S.u,{property:U.IZ_,renderNewExperience:()=>(0,E.jsx)("div",{className:re,children:(0,E.jsx)(Y.d,{sortOptions:[te.nw.TITLE,te.nw.ADDED_AT,te.nw.ARTIST,te.nw.ALBUM,te.nw.DURATION],defaultSortField:te.nw.ADDED_AT,filterPlaceholder:d.Ru.get("playlist.search_in_playlist"),enableViewModeMenu:!0})}),renderOldExperience:()=>(0,E.jsx)(v,{tracklistDomRef:p})})}):(0,E.jsx)("div",{className:re,children:(0,E.jsx)(S.u,{property:ae.mA,renderNewExperience:()=>(0,E.jsx)(I.g,{options:[],onSelect:()=>{},selected:null,enableViewModeMenu:!0})})})]}),R&&(0,E.jsx)(W,{spec:h,nrTracks:m})]})}));var ie=l(89662),ne=l(23617),oe=l(98486);var ce=l(13343),de=l(66433);var ue=l(64497),ge=l(19486),me=l(30164),pe=l(43915);const ye=({ariaLabel:e,columns:t,columnPersistenceKey:l,renderItem:r,defaultSortField:i})=>{const{playlist:n}=(0,ge.g)(),o=(0,pe.m)(),{canFetchAllTracks:c}=o.getCapabilities(),d=(0,ue.K_)(),u=(0,a.useRef)(null),{isCompactMode:g}=(0,me.a)(),m="custom-order"===i;(e=>{const t=(0,s.wQ)(),l=(0,s.zy)(),r="POP"!==t?new URLSearchParams(l.search).get("uid"):null;(0,a.useLayoutEffect)((()=>{e.current&&r&&e.current.scrollToItem({uid:r})}),[r,e])})(u);const{trackListSortState:p,onSort:y}=((e,t)=>{const{sortState:l,setSortState:r}=(0,ce.kW)(),s=(0,a.useMemo)((()=>(0,de.Ap)(e,l)),[e,l]),i=(0,a.useCallback)((e=>{r((0,de.hK)(e,s,t))}),[t,r,s]);return{trackListSortState:s,onSort:i}})(t,m),f=(0,a.useCallback)((e=>({uri:e.uri,uid:e.uid,type:e.type})),[]),x=(0,a.useMemo)((()=>new Set((0,de.g6)(t))),[t]);return(0,E.jsx)(h.a,{columns:t,children:(0,E.jsx)(oe.g0,{ariaLabel:e,hasHeaderRow:!0,columns:t,sortableColumns:x,sortState:p,onSort:y,renderRow:r,resolveItem:f,itemsCache:d,canFetchAllTracks:c,isCompactMode:g,columnPersistenceKey:l,outerRef:u},n.metadata.uri+g)})};var fe=l(95309),he=l(44984),xe=l(74971);const ke=[x.$.INDEX,x.$.TITLE_AND_ARTIST,x.$.ALBUM,x.$.ADDED_AT,x.$.DURATION],be=a.memo((function({usePlayContextItem:e}){const{isCompactMode:t}=(0,me.a)(),l=(({isCompactMode:e=!1})=>{const t=[...ke];return e&&t.splice(t.indexOf(x.$.TITLE_AND_ARTIST),1,x.$.TITLE,x.$.ARTIST),t})({isCompactMode:t}),{playlist:{metadata:r}}=(0,ge.g)(),s=(0,a.useCallback)(((l,a)=>{if(!(0,he.Jy)(l))return(0,E.jsx)(E.Fragment,{});const s=(0,xe.g)(l.album?.images,{desiredSize:40,desiredLabel:"small"});return(0,E.jsx)(ne.W,{index:a,contextUri:r.uri,uri:l.uri,isPlayable:l.isPlayable,duration_ms:l.duration.milliseconds,name:l.name,artists:l.artists,albumOrShow:l.album,isExplicit:l.isExplicit,isMixedMedia:!1,isPaywalled:!1,isUserSubscribed:!1,isLocal:l.isLocal,addedBy:[],dateAdded:l.addedAt,hasDecoratedAddedBy:!1,release_date:"",isMOGEFRestricted:l.is19PlusOnly,type:l.type,imgUrl:s?.url||"",onMove:()=>{},onInsert:()=>{},usePlayContextItem:e,allowedDropTypes:[],isDisliked:!1,playlistName:d.Ru.get("sidebar.liked_songs"),isOwnedBySelf:!0,isCompactMode:t,hasAssociatedVideo:l.hasAssociatedVideo},a+l.uri)}),[r.uri,e,t]);return(0,E.jsx)(fe.pZ,{value:"liked-songs-tracklist",children:(0,E.jsx)(ye,{ariaLabel:d.Ru.get("sidebar.liked_songs"),columns:l,renderItem:s,columnPersistenceKey:"liked-songs-tracklist",defaultSortField:te.nw.ADDED_AT})})}));var Ce=l(7557),Se=l(8476),Te=l(25336),Ie=l(88417),Ae=l(50885);const Fe=()=>{const{playlist:{metadata:e},contentsOptions:t}=(0,ge.g)(),l=(0,pe.m)(),{canSort:r,canFilter:s}=l.getCapabilities(),{uri:n,name:c,totalLength:m}=e,p=(0,Se.z)("#5038a0"),{spec:y,logger:h}=(0,D.r)(o.k,{data:{uri:n}}),x=a.useMemo((()=>y.headerFactory()),[y]),k=a.useMemo((()=>y.tracklistFactory()),[y]),{isPlaying:b,togglePlay:C,usePlayContextItem:S,isActive:T}=(0,Ie.P)((0,Ae.A)(e.uri,t),{featureIdentifier:"your_library",referrerIdentifier:"your_library"}),I=()=>{const e=(0,Te.$I)({isPlaying:b,isActive:T,spec:y.actionBarFactory().playButtonFactory(),logger:h,uri:n});C({loggingParams:e})},[A]=(0,f.z1)();return(0,E.jsxs)("section",{role:"presentation",className:R.A.playlist,"data-testid":"playlist-page",children:[(0,E.jsx)(u.Q,{children:d.Ru.get("playlist.page-title",c)}),(0,E.jsx)(Ce.x,{metadata:{...e,hasSpotifyTracks:!0},totalItems:A,isPlaying:b,togglePlay:I,backgroundColor:p,specLikedSongs:x}),(0,E.jsx)(se,{metadata:e,onClickTogglePlay:I,isPlaying:b,spec:y,logger:h,backgroundColor:p,canSort:r,canFilter:s}),(0,E.jsx)("div",{className:"contentSpacing",children:m>0?(0,E.jsx)(le.r,{spec:k,children:(0,E.jsx)(be,{usePlayContextItem:S})}):(0,E.jsx)(g.p,{message:d.Ru.get("collection.empty-page.songs-subtitle"),title:d.Ru.get("collection.empty-page.songs-title"),linkTo:"/search",linkTitle:d.Ru.get("collection.empty-page.songs-cta"),renderInline:!0,children:(0,E.jsx)(i.v,{"aria-hidden":"true"})})})]})};var je=l(20154),we=l(88308),De=l(94648),Re=l(84766);var Ee=l(60815),ve=l(95052),Pe=l(66679),Le=l(3783),Me=l(60857),_e=l(63854),Ne=l(10058);function Oe(e,t,l){const a={uri:e};return(0,Le.qq)(a,t),(0,Me.Pz)(a,l?.map((e=>(0,_e.HI)(e)??null)).filter(Ne.P)),a}const Ue=[x.$.INDEX,x.$.TITLE_AND_ARTIST,x.$.ALBUM,x.$.ADDED_AT,x.$.DURATION],Be=({data:e,canFilter:t,canSort:l})=>{const{uri:r,name:n,totalLength:c}=e.metadata,k=(0,a.useRef)(null),b=(0,Se.z)("#5038a0"),[C]=K(),{filter:S}=(0,a.useContext)(p.g),{sortState:T,setSortState:I}=(0,a.useContext)(y.cL),{spec:A,logger:F}=(0,D.r)(o.k,{data:{uri:r}}),j=a.useMemo((()=>A.headerFactory()),[A]),w=a.useMemo((()=>A.tracklistFactory()),[A]);(0,a.useEffect)((()=>{null===T.column&&I({column:x.$.ADDED_AT,order:x.H.DESC})}),[T,I]);const v=(0,s.wQ)(),P=(0,s.zy)(),L="POP"!==v?new URLSearchParams(P.search).get("uri"):null,{isPlaying:M,togglePlay:_,usePlayContextItem:N,isActive:O}=(0,Ie.P)(Oe(r,(0,ie.c)(T),[S,C].filter(Ne.P)),{featureIdentifier:"your_library",referrerIdentifier:"your_library"}),U=()=>{const e=(0,Te.$I)({isPlaying:M,isActive:O,spec:A.actionBarFactory().playButtonFactory(),logger:F,uri:r});_({loggingParams:e})},[B]=(0,f.z1)(),{isCompactMode:$}=(0,me.a)(),V=(({isCompactMode:e=!1})=>{const t=[...Ue];return e&&t.splice(t.indexOf(x.$.TITLE_AND_ARTIST),1,x.$.TITLE,x.$.ARTIST),t})({isCompactMode:$});return(0,E.jsx)(h.a,{columns:V,children:(0,E.jsxs)("section",{role:"presentation",className:R.A.playlist,"data-testid":"playlist-page",children:[(0,E.jsx)(u.Q,{children:d.Ru.get("playlist.page-title",n)}),(0,E.jsx)(Ce.x,{metadata:{...e.metadata,hasSpotifyTracks:!0},totalItems:B,isPlaying:M,togglePlay:U,backgroundColor:b,specLikedSongs:j}),(0,E.jsx)(se,{metadata:e.metadata,onClickTogglePlay:U,isPlaying:M,spec:A,logger:F,backgroundColor:b,canSort:l,canFilter:t}),(0,E.jsx)("div",{className:"contentSpacing",children:c>0?(0,E.jsx)(a.Suspense,{fallback:(0,E.jsx)(m.LoadingPage,{hasError:!1,errorMessage:d.Ru.get("error.request-collection-tracks-failure")}),children:(0,E.jsx)(le.r,{spec:w,children:(0,E.jsx)(je.b,{nrTracks:c,collectionUri:r,scrollToUri:L,usePlayContextItem:N,outerDomRef:k,spec:w,initialItems:e.contents.items,isCompactMode:$,tagFilter:C})})}):(0,E.jsx)(g.p,{message:d.Ru.get("collection.empty-page.songs-subtitle"),title:d.Ru.get("collection.empty-page.songs-title"),linkTo:"/search",linkTitle:d.Ru.get("collection.empty-page.songs-cta"),renderInline:!0,children:(0,E.jsx)(i.v,{"aria-hidden":"true"})})})]})})},$e=a.memo((function({user:e,uri:t}){const{filter:l}=(0,a.useContext)(p.g),{sortState:r}=(0,a.useContext)(y.cL),[s]=K(),i=function(e,t,l){const r=(0,$.f)(),s=(0,_.jE)(),i=(0,we.U0)((()=>["useLikedSongs",e,l]),[e,l]),{data:n}=(0,N.I)({queryKey:i(),queryFn:()=>r.getTracks(l),gcTime:18e5,placeholderData:O.rX,refetchOnWindowFocus:!1}),o=(0,a.useCallback)((()=>{s.invalidateQueries({queryKey:i()})}),[s,i]);(0,V.l)(B.UV.UPDATE,o);const c=(0,De.$R)(t.id);return c&&n?{metadata:{uri:e,name:c.name,images:c.images,totalLength:n?.totalLength,unfilteredTotalLength:n.unfilteredTotalLength,owner:(0,Re.w)(t)},contents:n}:null}(t,e,{offset:0,limit:25,sort:(0,ie.c)(r),filters:[l,s].filter(Ne.P)}),n=(0,$.f)().getCapabilities();return i?(0,E.jsx)(Be,{data:i,canFilter:n.canFilterTracksAndEpisodes&&i.metadata.unfilteredTotalLength>0,canSort:n.canSortTracksAndEpisodes&&i.metadata.unfilteredTotalLength>0}):(0,E.jsx)(m.LoadingPage,{hasError:!1,errorMessage:d.Ru.get("error.not_found.title.playlist"),loadOffline:n.canModifyOffline})})),Ve=()=>{const{user:e}=(0,r.d4)(ve.Ht);if((0,n.NC)(U.IZ_,{loadingValue:!1}))return(0,E.jsx)(Ee.W,{uri:Pe.DK,children:(0,E.jsx)(Fe,{})});if(null===e)return null;const t=(0,c.fHB)(e.id).toURI();return(0,E.jsx)(y.sn,{uri:t,children:(0,E.jsx)(p.s,{uri:t,children:(0,E.jsx)(f.S1,{children:(0,E.jsx)($e,{uri:t,user:e})})})})}}}]);
//# sourceMappingURL=xpui-routes-collection-songs.js.map