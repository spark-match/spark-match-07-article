"""Recorta margenes blancos sobrantes de los PNG renderizados desde Mermaid.
mermaid-cli a veces deja mucho lienzo en blanco (viewport fijo de Puppeteer)
por debajo/derecha del contenido real. Uso:
    python autocrop.py ../fig-user-journey.png [...]
"""
import sys
from PIL import Image, ImageChops

MARGIN = 20

def autocrop(path):
    img = Image.open(path).convert("RGB")
    bg = Image.new("RGB", img.size, (255, 255, 255))
    diff = ImageChops.difference(img, bg)
    bbox = diff.getbbox()
    if not bbox:
        return
    left, top, right, bottom = bbox
    left = max(0, left - MARGIN)
    top = max(0, top - MARGIN)
    right = min(img.width, right + MARGIN)
    bottom = min(img.height, bottom + MARGIN)
    cropped = Image.open(path).crop((left, top, right, bottom))
    cropped.save(path)
    print(f"{path}: {img.size} -> {cropped.size}")

if __name__ == "__main__":
    for p in sys.argv[1:]:
        autocrop(p)
