#!/usr/bin/env python3
"""Recreate attributed figure crops from the checked-in IACR papers.

Requires PyMuPDF. Ordinary slide compilation uses the existing PNGs and does not
require it. Cropping coordinates are PDF points with a top-left origin.
"""

import hashlib
import json
from pathlib import Path

import fitz


def main():
    assets = Path(__file__).resolve().parent
    output = assets / "paper-figures"
    crops = json.loads((output / "manifest.json").read_text())
    checksums = {
        name: checksum
        for checksum, name in (
            line.split()
            for line in (assets / "papers/SHA256SUMS").read_text().splitlines()
        )
    }
    for crop in crops:
        source = assets / "papers" / crop["pdf"]
        if hashlib.sha256(source.read_bytes()).hexdigest() != checksums[source.name]:
            raise ValueError(f"Source version changed: {source}")
        with fitz.open(source) as document:
            page = document[crop["page"] - 1]
            rectangle = fitz.Rect(crop["rect"])
            if not page.rect.contains(rectangle):
                raise ValueError(f"Crop outside page: {crop['name']}")
            page.get_pixmap(clip=rectangle, dpi=450, alpha=False).save(
                output / f"{crop['name']}.png"
            )
        print(f"{crop['name']}: {source.name}, PDF p.{crop['page']}, {crop['figure']}")


if __name__ == "__main__":
    main()
