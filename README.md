# playground
🍙 The Linux playground for hobby use on yude.jp

## Limitation
* No internet connection.
* You need to send us a PR in order to add packages. (`packages.txt`)
* 256MB RAM, 10GB storage (but these won't be reflected to `df -h`, `free`, etc.)

## How to join
1. Fork this repository.
2. Edit `add-ssh-key.sh` in order to import your SSH public key.
3. Send us a pull-request.

If your PR is merged, do the following:

4. Install `cloudflared` to your computer.
5. Paste below to your `$HOME/.ssh/config`.
    ```
    Host playground.yude.jp
        User root
        HostName playground.yude.jp
        ProxyCommand cloudflared access ssh --hostname %h
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null
    ```
6. Run `ssh playground.yude.jp`.

## License
MIT License.