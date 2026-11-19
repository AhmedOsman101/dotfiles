# Environment

- id: environment-001
  date: 2026-11-14
  tags: [cerulean,install,luarocks,lua]
  project: cerulean
  fact: System Lua is 5.5 (/usr/bin/lua, lua5.5). ceru is installed via `sudo make rock` (luarocks dev-1) at /usr/bin/ceru + /usr/share/lua/5.5/cerulean; modules compiled from local dist/. Do NOT use plain `make install` — its default LUADIR=/usr/local/share/lua/5.4 mismatches system Lua 5.5, producing a duplicate/stale wrapper. To reinstall after source changes: make compile && sudo make rock. Uninstall with `sudo luarocks remove cerulean`.

- id: environment-002
  date: 2026-11-14
  tags: [rustow,name-collision,aur,gitlab,distribution]
  project: rustow
  fact: The name 'rustow' is taken by Erenoit/rustow on GitLab (gitlab.com/Erenoit/rustow), published on AUR as rustow-git (submitted 2022-10-21, GPL-3.0+, ~68 commits, v1.0 June 2024, last commit 2024-07-18). Independent same-name GNU Stow replacement in Rust; not a fork of this project. AUR lookup confirmed 2026-11-14. Constraint: this project cannot publish to AUR under 'rustow-git'. Project ships publish=false (no crates.io); GitHub repo is AhmedOsman101/Rustow (namespaced, no collision). Renaming the binary/crate would touch config dir, env vars, docs, hooks — heavy for zero functional gain.

- id: environment-003
  date: 2026-11-16
  tags: [pdfx, llamaparse, pdf extraction, summarize-material]
  fact: summarize-material skill (updated 2026-11): pdfx --llamaparse tier table — fast=1 credit/page (text-only), cost_effective=3 (text-heavy, NO images), agentic=10 (straightforward diagrams/images), agentic_plus=25 (complex layouts/diagrams). Image-heavy slide decks MUST use agentic or higher, never cost_effective; agentic-full undocumented — ask first. 20,000 credits/month budget; always estimate pages×tier before spending; per-page re-extract on failure, never re-dump whole file. Still: question-tool go-ahead or pre-authorization first ('use llamaparse' in the request); garbage-but-nonempty = ask. User corrected tier choice on 2026-11-16: cost_effective was wrong for Section-1.pdf (billed 3/page but images need agentic 10/page).

- id: environment-004
  date: 2026-11-18
  tags: [hardware, disks, lean11, windows11, kvm, vm]
  fact: othman's PC: Arch, i3-10105F 4c/8t, 16GB RAM, GTX 660 (Kepler, EOL nvidia 470 driver), /dev/kvm available. Disks: /dev/sda 120GB = Win10 (problematic), /dev/sdb 512GB btrfs = Arch root (~162G free; work dirs must go here, /tmp is tmpfs 7.8G), /dev/sdc 1TB NTFS = games. lean11 tool at ~/programs/lean11-0.1.1-linux-x86_64 (bin/lean11 v0.1.1); Win11 26H2 ISO build 26300.9457 in ~/Downloads/OSimages/.

- id: environment-005
  date: 2026-11-18
  tags: [virt-manager, win11-vm, spice, webdav, shared-folder]
  fact: virt-manager VM 'win11': q35/OVMF + Secure Boot, 4 vCPU, 8GB RAM, SATA disk /var/lib/libvirt/images/win11.qcow2, e1000e NIC, SPICE graphics, existing spicevmc channel com.redhat.spice.0, swtpm 2.0. Installed successfully from ~/Downloads/OSimages/lean11/lean11.iso (trimmed Win11 26H2, Defender+WU disabled, ~2GB RAM/125 processes). Folder sharing: add spicevmc channel org.spice-space.webdav.0 via 'virt-xml win11 --add-device --channel spicevmc,name=org.spice-space.webdav.0'; guest needs virtio-serial driver (virtio-win-0.1.240.iso) + spice-webdavd-x64-2.4.msi; host connects with 'spicy --spice-shared-dir=/home/othman/Public --uri=<virsh domdisplay win11>'. virt-viewer/remote-viewer not installed; spicy is.

- id: environment-006
  date: 2026-11-19
  tags: [pnpm, mask, path, pass-gui, typecheck, format]
  fact: In this agent shell PATH, `pnpm` is missing, so `mask typecheck`/`mask format` fail with `pnpm: command not found`. A working pnpm 12.14.0 binary exists at /home/othman/.local/share/pnpm/package-manager-store/v11/links/@/pnpm/12.14.0/a9c2e4d2f066285cbeab841072cb8c0c5e4bd148a2f983cd9062f6ec5b4ca487/bin — prepend that directory to PATH when invoking mask (do not run pnpm directly; AGENTS.md forbids it).

- id: environment-007
  date: 2026-11-19
  tags: [opencode,subagent,senior-review,agent-id]
  fact: In this OpenCode setup the subagent tool rejects agent ids `senior-review` and `senior_review` (error: 'Unknown agent'); the working id for the senior-review role is `senior-reviewer`.

- id: environment-008
  date: 2026-11-19
  tags: [neutralino fork,pnpm update,dependency version,pass-gui]
  project: pass-gui
  fact: pass-gui pins @neutralinojs/lib to the GitHub fork github:AhmedOsman101/neutralino.js#pnpm (see root package.json + pnpm-lock.yaml codeload tarball). The fork's package.json version is 6.9.0 — identical to stock npm 6.9.0 — so the version number alone cannot tell fork from npm; do not flag a fork->npm swap based on version alone. 'pnpm update' bumps many resolved versions in node_modules but package.json uses caret ranges, so the fork spec stays; if the lockfile is reverted, node_modules drift is local-only.

- id: environment-009
  date: 2026-11-19
  tags: [libvirt, gnome-boxes, void-linux, samba, vm-network, runit]
  fact: Both VMs live on qemu:///system: win11 and voidlinux (disk /var/lib/libvirt/images/voidlinux). Boxes source uri=qemu+unix:///system; session connection empty. Boxes needed its own lowercase 'gnome-boxes' dir pool (stale capitalized 'Gnome Boxes' pool caused 'Storage source conflict'; fixed by destroy+undefine). voidlinux NIC switched from SLIRP to libvirt 'default' NAT network; IP 192.168.122.187. Host Samba shares /home/othman/Public as \\192.168.122.1\vm bound to virbr0+loopback, user othman (password user-managed). Void uses runit NOT systemd: x-systemd.automount is ignored and boot skips _netdev mounts, so auto-mount is via /etc/NetworkManager/dispatcher.d/99-vm-share (mounts on eth0 up) with creds /etc/samba-vm.creds. win11 maps the same share as Y: (Z: is WebDAV). QEMU guest agent works in voidlinux via virsh guest-exec. othman is in libvirt group; sudo -A works.
