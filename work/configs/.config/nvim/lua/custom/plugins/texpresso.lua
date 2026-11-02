-- Live LaTeX preview. Requires the `texpresso` binary on PATH (AUR: texpresso-git).
-- Usage: open a .tex file and run :TeXpresso % (or :TeXpresso path/to/main.tex for multi-file docs).
return {
  {
    'let-def/texpresso.vim',
    ft = 'tex',
    cmd = 'TeXpresso',
  },
}
