## Fallout GRUB theme

Supported languages: Chinese (simplified), Chinese (traditional), English, French, German, Hungarian, Italian, Korean, Latvian, Norwegian, Polish, Portuguese, Russian, Rusyn, Spanish, Turkish, Ukrainian

![](https://i.imgur.com/7LUYwTn.gif)

---

### Installation / update

1. **Secure way:**
    - Download install script:  
    `wget -P /tmp https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh`
    - Review install script at `/tmp/install.sh`
    - Run it: `bash /tmp/install.sh`

2. **Easier, less secure way** — just download and run install script:  
    `wget -O - https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash`

<br>

You can use `--lang` option to select language and disable interactive language selection, e.g.:

```sh
bash /tmp/install.sh --lang German
```

or

```sh
wget -O- https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash -s -- --lang Korean
```

Full list of languages see in `INSTALLER_LANGS` variable in [install.sh](install.sh)

---

### See also

- [Poly light GRUB theme](https://github.com/shvchk/poly-light)
- [Poly dark GRUB theme](https://github.com/shvchk/poly-dark)
