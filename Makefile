ASM = nasm
SRC_DIR = src
BUILD_DIR = build

all: clean $(BUILD_DIR) $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/bootloader.bin
	cp $< $@
	truncate -s 1440k $@

$(BUILD_DIR)/bootloader.bin: $(SRC_DIR)/bootloader.asm $(SRC_DIR)/main.asm
	$(ASM) $(SRC_DIR)/bootloader.asm -f bin -o $@

run: $(BUILD_DIR)/main_floppy.img
	qemu-system-i386 -fda $(BUILD_DIR)/main_floppy.img

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean run
