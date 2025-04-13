_default:
  @just --list

output_dir := "dist"

# Remove output directory
clean:
  rm -rfv {{output_dir}}

_build:
  # Ensure output directory exists
  mkdir -p "{{output_dir}}/sddm-gruvbox"

  # Copy all source files
  cp -r src/* "{{output_dir}}/sddm-gruvbox"

  # Copy per-theme assets
  cp "assets/gruvbox.png" "{{output_dir}}/sddm-gruvbox/preview.png"

# Build theme
build: clean _build

# Create zip archive
zip: build
  cd {{output_dir}} ; zip -r sddm-gruvbox.zip sddm-gruvbox

# Install theme system-wide
install: build
  cp -r {{output_dir}}/sddm-gruvbox /usr/share/sddm/themes/
