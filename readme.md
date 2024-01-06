# ⚡ shifter
A minimalist, versatile and opinionated theme for tmux.

<p>
<img src="assets/theme-nord.png" />
</p>

> ⚠️ Work in Progress: This project is actively evolving. Expect updates and changes. Please use cautiously, and feel free to contribute or suggest features through GitHub issues.

## Features
- Opinionated UI with sane defaults 💡
- Support for popular themes like `nord` and `catppuccin` 🎨
> Check the list of supported themes [here](/#supported-themes).

## Installing
Using [tpm](https://github.com/tmux-plugins/tpm), add this to your `tmux.conf`
```sh
set -g @plugin 'bettervim/shifter'
set -g @shifter_theme 'nord'
```

## Options
Shifter, while incorporating some opinionated defaults, offers flexibility through customizable global options. To tailor the behavior of Shifter to your specific needs, simply include the desired options after declaring the plugin in your tmux.conf file.
> 🔗 You can check [this](https://github.com/vmarcosp/dotfiles/blob/75803561bd6a4a050bdaa8fcca2e9c38895f2764/tmux/.tmux.conf#L38) tmux conf as a guide.

### Setting a theme
```sh
set -g @shifter_theme '<theme-name>'
```
> :bulb: Check the list of available themes.

## Window modules 
```sh
set -g @shifter_theme '<layout>'
# For example:
set -g @shifter_theme '#number: #name'
```
Available window modules are:
- `#number`
- `#name`

> :bulb: You can use any char of your preference as a separator/prefix/sufix inside of '...'

### Aside modules
```sh
set -g @shifter_aside_modules '<layout>'
# For example:
set -g @shifter_aside_modules '#clock #session-name'
```
Available aside modules are:
- `#clock`
- `#session-name`
- `#hostname`

> :bulb: You can use any char of your preference as a separator/prefix/sufix inside of '...'

### Aside separator
```sh
set -g @shifter_aside_separator '<'
```

## Supported themes
- [x] `nord`
- [x] `everforest`
- [x] `poimandres`
- [x] `catppuccin`

Work in progress, will be released soon ⚙️
- [ ] `ayu`
- [ ] `dracula`
- [ ] `tokyonight`

## License
MIT
