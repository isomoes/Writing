#!/usr/bin/env python3
"""Build the standalone figures and the Chinese research-sharing slides.

Run from any directory. Requires Typst 0.14+ and the fonts in style.typ.
Use --preview-dir PATH to render temporary PNGs for visual inspection.
"""

import argparse
from pathlib import Path
import subprocess


def compile_typst(root, source, target, *options):
    subprocess.run(
        ["typst", "compile", "--root", str(root), *options, str(source), str(target)],
        check=True,
        cwd=root,
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--preview-dir", type=Path)
    parser.add_argument(
        "--extract-paper-figures",
        action="store_true",
        help="regenerate attributed crops (requires PyMuPDF)",
    )
    args = parser.parse_args()
    assets = Path(__file__).resolve().parent
    root = assets.parent.parent
    source = assets.parent / "sca-deep-learning.typ"
    preview = args.preview_dir.resolve() if args.preview_dir else None
    if preview:
        preview.mkdir(parents=True, exist_ok=True)

    if args.extract_paper_figures:
        import sys

        subprocess.run(
            [sys.executable, str(assets / "extract-paper-figures.py")], check=True
        )

    for figure in sorted((assets / "figures").glob("*.typ")):
        compile_typst(root, figure, figure.with_suffix(".svg"))
        if preview:
            compile_typst(root, figure, preview / f"{figure.stem}.png", "--ppi", "120")

    compile_typst(root, source, source.with_suffix(".pdf"))
    if preview:
        compile_typst(root, source, preview / "slide-{p}.png", "--ppi", "90")
    print(f"Built {source.with_suffix('.pdf')}")


if __name__ == "__main__":
    main()
