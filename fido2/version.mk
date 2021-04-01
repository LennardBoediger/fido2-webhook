
SOLO_VERSION_FULL=2.4.0.nitrokey
SOLO_VERSION:=$(shell python3 -c 'print("$(SOLO_VERSION_FULL)".split("-")[0])')
SOLO_VERSION_MAJ:=$(shell python3 -c 'print("$(SOLO_VERSION)".split(".")[0])')
SOLO_VERSION_MIN:=$(shell python3 -c 'print("$(SOLO_VERSION)".split(".")[1])')
SOLO_VERSION_PAT:=$(shell python3 -c 'print("$(SOLO_VERSION)".split(".")[2])')

SOLO_VERSION_FLAGS := -DSOLO_VERSION_MAJ=$(SOLO_VERSION_MAJ) -DSOLO_VERSION_MIN=$(SOLO_VERSION_MIN) \
	-DSOLO_VERSION_PATCH=$(SOLO_VERSION_PAT) -DSOLO_VERSION=\"$(SOLO_VERSION_FULL)\"
