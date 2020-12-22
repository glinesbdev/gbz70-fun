SECTION "Header", ROM0[$100]

EntryPoint:
    di
    jp Start

REPT $150 - $104
    db 0
ENDR

SECTION "Game code", ROM0

Start:
.waitVBlank
    ld a, [$FF44]
    cp 144
    jr c, .waitVBlank

    xor a
    ld [$FF40], a
    ld hl, $9000
    ld de, FontTiles
    ld bc, FontTilesEnd - FontTiles

.copyFont
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .copyFont

    ld hl, $9800
    ld de, HelloWorldStr

.copyString
    ld a, [de]
    ld [hli], a
    inc de
    and a
    jr nz, .copyString

.screenSetup
    ld a, %11100100
    ld [$FF47], a

    xor a
    ld [$FF42], a
    ld [$FF43], a

    ld [$FF26], a

    ld a, %10000001
    ld [$FF40], a

.lockup
    jr .lockup

SECTION "Font", ROM0

FontTiles:
INCBIN "src/includes/font.chr"
FontTilesEnd:

SECTION "Hello World string", ROM0

HelloWorldStr:
    db "Hello World!", 0
