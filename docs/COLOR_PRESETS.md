# Color Presets

Ready-to-use color configurations for Modern Backend Theme. To apply a preset, replace the SCSS variables at the top of `static/src/scss/backend_theme.scss`.

---

## Indigo (Default)

```scss
$cmt-primary:         #6366f1;
$cmt-primary-hover:   #4f46e5;
$cmt-primary-active:  #4338ca;
$cmt-primary-light:   #ede9fe;
$cmt-primary-border:  #c7d2fe;
$cmt-primary-rgb:     99, 102, 241;
```

## Ocean Blue

```scss
$cmt-primary:         #3b82f6;
$cmt-primary-hover:   #2563eb;
$cmt-primary-active:  #1d4ed8;
$cmt-primary-light:   #dbeafe;
$cmt-primary-border:  #93c5fd;
$cmt-primary-rgb:     59, 130, 246;
```

## Forest Green

```scss
$cmt-primary:         #10b981;
$cmt-primary-hover:   #059669;
$cmt-primary-active:  #047857;
$cmt-primary-light:   #d1fae5;
$cmt-primary-border:  #6ee7b7;
$cmt-primary-rgb:     16, 185, 129;
```

## Sunset Orange

```scss
$cmt-primary:         #f97316;
$cmt-primary-hover:   #ea580c;
$cmt-primary-active:  #c2410c;
$cmt-primary-light:   #fff7ed;
$cmt-primary-border:  #fdba74;
$cmt-primary-rgb:     249, 115, 22;
```

## Royal Purple

```scss
$cmt-primary:         #8b5cf6;
$cmt-primary-hover:   #7c3aed;
$cmt-primary-active:  #6d28d9;
$cmt-primary-light:   #ede9fe;
$cmt-primary-border:  #c4b5fd;
$cmt-primary-rgb:     139, 92, 246;
```

## Ruby Red

```scss
$cmt-primary:         #ef4444;
$cmt-primary-hover:   #dc2626;
$cmt-primary-active:  #b91c1c;
$cmt-primary-light:   #fee2e2;
$cmt-primary-border:  #fca5a5;
$cmt-primary-rgb:     239, 68, 68;
```

## Teal

```scss
$cmt-primary:         #14b8a6;
$cmt-primary-hover:   #0d9488;
$cmt-primary-active:  #0f766e;
$cmt-primary-light:   #ccfbf1;
$cmt-primary-border:  #5eead4;
$cmt-primary-rgb:     20, 184, 166;
```

## Rose Pink

```scss
$cmt-primary:         #f43f5e;
$cmt-primary-hover:   #e11d48;
$cmt-primary-active:  #be123c;
$cmt-primary-light:   #ffe4e6;
$cmt-primary-border:  #fda4af;
$cmt-primary-rgb:     244, 63, 94;
```

---

## Custom Colors

You can use any color. Just make sure to:

1. Set `$cmt-primary` to your main brand color
2. Set `$cmt-primary-hover` slightly darker (use a tool like [HSL picker](https://hslpicker.com))
3. Set `$cmt-primary-active` even darker for pressed states
4. Set `$cmt-primary-light` to a very light tint for backgrounds
5. Set `$cmt-primary-border` to a light shade for subtle borders
6. Set `$cmt-primary-rgb` to the RGB values (for `rgba()` usage)
