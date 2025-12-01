# Creating a Continuous background leverage loop

First install UTM
https://termius.com/index.html

```bash
brew install --cask utm
```


Download Ubuntu Server (DMG)

https://ubuntu.com/download/server/arm



On iphone download Termius
https://termius.com/index.html




1. Core Infrastructure: Sandboxed VM for Agents

Choose a hypervisor: On your Mac, use UTM
 (easy GUI, sandboxed) or VMware Fusion/Parallels (if you want more performance). UTM is great because it uses Apple’s Hypervisor framework (no kernel extensions).
OS choice: A lightweight Linux (Ubuntu Server or Debian) with minimal GUI. Easier to keep lean and secure.

Isolation: Run the VM in a dedicated user account or with AppArmor/SELinux profiles enabled inside the VM. This ensures agents can’t touch host files.

Networking: Configure VM networking in bridged mode so you can SSH into it from your phone.




2. Remote Access: Mosh/SSH + Termius

Install Mosh: On macOS, brew install mosh. Inside the VM: sudo apt install mosh.

Set up keys: Generate an SSH keypair (ssh-keygen -t ed25519) and copy the public key into your VM’s ~/.ssh/authorized_keys.

Termius setup on iOS:

Import your private key.

Add your VM as a host.

Use Mosh (if available) for resilience against mobile dropouts (great for train rides, office wifi handoffs, etc.).




3. Agent Runtime

Claude or LLM agents: Inside the VM, you’ll want a clean runtime environment:

Install Python/Node (depending on agent framework).

Containerize if possible (Docker or Podman inside VM). That way, each agent runs sandboxed inside a container even within the VM.

Separate directories/worktrees for parallel tasks (your “multiple TODOs in flight” mode).

Modes (Plan vs Execute): You can script wrappers:

plan.sh <task> → runs an “Ultra-Think” planning mode (low-permission, only drafts JSON/Markdown plan).

exec.sh <planfile> → switches to YOLO execution mode (full sandboxed environment).

These could be just shell scripts that launch the agent with different configs.




4. Workflow Integration (Phone ↔ Life)

Kick-off from phone: Termius → plan.sh backlog-item-123.

Validate quickly: Later, cat backlog-item-123/plan.md or tail the log.

Flip mode: exec.sh backlog-item-123/plan.md.

Parallel progress: Use tmux or screen inside the VM so each task has a session. Example:

tmux new -s task1

tmux new -s task2

Detach/reattach from phone or Mac seamlessly.

Logging: Write outputs to ~/tasks/<id>/output.log so you can skim quickly on mobile without scrolling terminals.




5. Lifestyle Fit

Morning commute: Launch plan.sh while walking/cycling.

At office: From Mac, connect with iTerm2 → attach tmux sessions → monitor multiple worktrees.

Afternoon queue: Start another plan.sh before heading home.

Evening: Use your phone to check plan.md, run exec.sh.

Dinner/family: Agent churns away inside the VM unattended.

Night wind-down: Skim results, validate, queue next run. The cycle continues.




6. Safety & QoL Additions

Resource control: Use cgroups inside VM to cap CPU/memory so agents don’t starve your Mac.

Auto-suspend/resume: Script VM to pause when idle and auto-resume on SSH connect (saves battery if on a laptop).

Notifications: Hook into ntfy or pushover to push a mobile notification when a plan completes.

Versioning: Git each worktree; agent writes commits → you review diffs later.




⚡️ Result:
Every available window in your day becomes leverage. From iPhone you kick off / validate / execute with just a few terminal commands, while the sandboxed VM keeps the agents contained and productive.
