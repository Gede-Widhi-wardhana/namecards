#!/bin/bash
set -e

echo "Memulai pengecekan test case"

ERRORS=0

for file in cards/*.html; do
  [ -e "$file" ] || continue

  filename=$(basename "$file")
  echo "Memeriksa $filename"

  if [[ "$filename" =~ [^a-z0-9._-] ]]; then
    echo "Gagal: nama file $filename dilarang menggunakan spasi atau huruf kapital"
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -qi "<title>" "$file" || ! grep -qi "<h1>" "$file"; then
    echo "Gagal: file $filename wajib menyertakan tag title dan h1"
    ERRORS=$((ERRORS + 1))
  fi

  if grep -qi "<script" "$file"; then
    echo "Gagal: file $filename dilarang berisi tag script"
    ERRORS=$((ERRORS + 1))
  fi
done

if [ $ERRORS -gt 0 ]; then
  echo "Pengujian selesai, ditemukan $ERRORS kesalahan"
  exit 1
fi

echo "Semua kartu nama lolos uji"