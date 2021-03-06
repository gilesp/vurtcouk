+++
tags = ["emacs"]
title = "Magit and Yubikey SSH configuration"
date = 2016-05-24T17:25:27Z
+++

I use a [Yubikey Neo](https://www.yubico.com/products/yubikey-hardware/yubikey-neo/) to store my ssh keys on. To do this, it's configured as a smart card, following [Yubikey's own directions](https://developers.yubico.com/yubico-piv-tool/SSH_with_PIV_and_PKCS11.html). It's great because it means I have no keys stored on my computers - it's extracted from the yubikey each time I need it. The end result it my ssh key is physically attached to my keyring.

Each time I want to use my ssh key, I have to enter a PIN to unlock the yubikey. This is no different to entering your ssh passphrase, except that [magit](https://magit.vc/) (the amazing emacs git interface) didn't recognise the prompt being provided by the smart card libraries and would never ask me to enter the PIN.

Thankfully, I managed to spend a bit of time today investigating this issue and found that magit uses a series of regexps for identifying various passphrase prompts and you can customise this quite easily.

Here's the customisation I use:

```emacs-lisp
(setq magit-process-password-prompt-regexps
      '("^\\(Enter \\)?[Pp]assphrase\\( for \\(RSA \\)?key '.*'\\)?: ?$"
        ;; match-group 99 is used to identify a host
        "^\\(Enter \\)?[Pp]assword\\( for '\\(?99:.*\\)'\\)?: ?$"
        "^.*'s password: ?$"
        "^Yubikey for .*: ?$"
        "^Enter PIN for '.*': ?$"))
```

It's the final regexp, the "Enter PIN&#x2026;" one that does it for me - the opensc libraries that interact with the Yubikey display that prompt when asking for the PIN. The other Yubikey prompt is presumably for an older method of communicating with the yubikey, maybe via gpg or the pam modules. The PIV smart card method is much simpler to configure.
