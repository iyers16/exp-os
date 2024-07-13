ASM = nasm
SRC_DIR = src
BUILD_DIR = build

# Collect all .asm files in the SRC_DIR
ASM_FILES = $(wildcard $(SRC_DIR)/*.asm)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(ASM_FILES))

all: clean $(BUILD_DIR) $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/bootloader.bin
	cp $< $@
	truncate -s 1440k $@

# Rule to compile bootloader.asm directly to binary
$(BUILD_DIR)/bootloader.bin: $(SRC_DIR)/bootloader.asm $(SRC_DIR)/main.asm
	$(ASM) $(SRC_DIR)/bootloader.asm -f bin -o $@

# Rule to compile each .asm file to .o object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm
	$(ASM) -f elf $< -o $@

run: $(BUILD_DIR)/main_floppy.img
	qemu-system-i386 -fda $(BUILD_DIR)/main_floppy.img

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean run
