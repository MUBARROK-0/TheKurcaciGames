# The Kurcaci Games

## 📋 Daftar Isi

1. [Deskripsi Singkat](#deskripsi-singkat)
2. [Latar Belakang & Tujuan](#latar-belakang--tujuan)
3. [Fitur Utama Game](#fitur-utama-game)
4. [Tampilan Game](#tampilan-game)
5. [Teknologi yang Digunakan](#teknologi-yang-digunakan)
6. [Struktur Folder Project](#struktur-folder-project)
7. [Cara Menjalankan Project](#cara-menjalankan-project)
8. [Kontrol Permainan](#kontrol-permainan)
9. [Penjelasan Mekanik Game](#penjelasan-mekanik-game)
10. [Alur Permainan](#alur-permainan)
11. [Catatan Penting & Pengembangan](#catatan-penting--pengembangan)

---

## 📖 Deskripsi Singkat

**The Kurcaci Games** adalah sebuah game platform 2D action-adventure yang dikembangkan menggunakan engine Godot 4.3. Game ini menghadirkan pengalaman bermain sebagai karakter kecil bernama Kurcaci (Hobbit) yang harus bertahan hidup melawan berbagai musuh, mengumpulkan item, dan mencapai tujuan akhir level dengan sistem checkpoint untuk savepoint.

Game ini menggabungkan elemen platformer klasik dengan sistem combat melee dan ranged attack, memberikan pengalaman gameplay yang dinamis dan interaktif.

---

## 🎯 Latar Belakang & Tujuan

### Latar Belakang

Proyek ini dikembangkan sebagai latihan dalam game development menggunakan Godot Engine. The Kurcaci Games menerapkan konsep-konsep penting dalam game design seperti:

- **Physics & Movement** - Sistem gravitasi dan kontrol karakter yang responsif
- **Enemy AI** - Implementasi AI musuh dengan detection dan attack patterns
- **Combat System** - Sistem serangan melee dan ranged attack
- **Level Design** - Penempatan platform, checkpoint, dan obstacle strategis
- **State Management** - Penggunaan signal dan state machine untuk mengatur alur game

### Tujuan Project

1. **Pembelajaran** - Memahami workflow development game di Godot
2. **Implementasi Mekanik** - Menerapkan sistem yang umum digunakan dalam game 2D
3. **Portfolio** - Menunjukkan kemampuan dalam game development dan GDScript
4. **Prototype** - Memberikan dasar yang dapat diperluas untuk pengembangan lebih lanjut

---

## 🎮 Fitur Utama Game

### 1. **Sistem Movement & Platforming**

- Kontrol karakter smooth dengan gravitasi realtime
- Jump mechanics dengan kontrol ketinggian
- Platform detection dan collision handling
- Facing direction (flip sprite saat berubah arah)

### 2. **Combat System Dual-Mode**

- **Melee Attack (R)** → Serangan jarak dekat dengan collision detection
  - Animasi serangan dengan timing collision activation
  - Area damage yang hanya aktif pada frame tertentu
  - Cooldown otomatis setelah animasi selesai
- **Range Attack (B)** → Serangan jarak jauh dengan projectile
  - Spawn bullet dengan delay 0.5 detik
  - Projectile bergerak sesuai facing direction
  - Deteksi collision dengan musuh otomatis

### 3. **Enemy AI System**

- **Skeleton Enemy** (Advanced)
  - Patroli dengan raycast edge detection
  - Detection area untuk mendeteksi pemain
  - Attack animation dengan frame-based collision
  - Death animation sebelum despawn
- **Basic Enemies** (Slime, Goblin, Trenggiling)
  - Patroli sederhana dengan direction reversal
  - Wall/edge detection via raycast
  - Die function untuk integrasi dengan player attack

### 4. **Checkpoint & Respawn System**

- Checkpoint markers di berbagai lokasi level
- Auto-save posisi saat pemain menyentuh checkpoint
- Respawn otomatis ke checkpoint terakhir saat mati
- Killzone detection untuk trigger respawn

### 5. **Item Collection**

- Coin collectibles yang dapat dikumpulkan
- Integration dengan player body collision
- Queue free otomatis setelah dikumpulkan

### 6. **Animation System**

- Multiple animation states:
  - **Player**: Idle, Run, Jump, Block, RangeAttack, Dead
  - **Enemies**: Walk, Attack, Dead variants
- Frame-based event triggering
- Signal integration untuk animation completion

---

## 🎬 Tampilan Game

### Demo Gameplay

<video width="100%" controls style="max-width: 800px; display: block; margin: 20px auto; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.3);">
  <source src="demo/thekurcacigames_demo.mp4" type="video/mp4">
  Browser Anda tidak mendukung tag video HTML5. Silakan download file: <a href="demo/thekurcacigames_demo.mp4">thekurcacigames_demo.mp4</a>
</video>

**Video Highlights:**

- Demonstrasi movement dan jump mechanics
- Contoh melee attack (R) melawan musuh
- Contoh range attack (B) menembak projectile
- Sistem checkpoint dan respawn saat jatuh
- Level design dengan platform dan obstacle
- Enemy AI dan combat interactions

---

## 💻 Teknologi yang Digunakan

| Aspek                | Detail                                       | Versi     |
| -------------------- | -------------------------------------------- | --------- |
| **Engine**           | Godot                                        | 4.3       |
| **Rendering**        | Forward Plus                                 | -         |
| **Bahasa Scripting** | GDScript                                     | -         |
| **Physics System**   | Physics2D                                    | Godot 4.3 |
| **Asset Format**     | PNG (sprites), .tscn (scenes), .gd (scripts) | -         |
| **Platform Target**  | PC (exportable ke platform lain)             | -         |

### Key Godot Features Digunakan:

- **CharacterBody2D** - Physics-based character movement
- **AnimationPlayer/AnimatedSprite2D** - Animation handling
- **Area2D** - Trigger-based collision detection
- **TileMap** - Level design dan platform rendering
- **RayCast2D** - Enemy detection dan navigation
- **Signal System** - Event-driven architecture
- **Global Groups** - Object identification ("Player", "enemy")

---

## 📁 Struktur Folder Project

```
TheKurcaciGames/
│
├── 📄 project.godot          # Konfigurasi project Godot
├── 📄 README.md               # File dokumentasi ini
├── 📄 icon.svg                # Project icon
│
├── 📁 assets/                 # Semua aset game
│   ├── character/             # Sprite karakter Kurcaci (attack, block, death frames)
│   ├── background/            # 5 layer background untuk parallax
│   ├── block/                 # Tileset untuk platform dan lingkungan
│   ├── enemy/                 # Sprite musuh (jika ada)
│   ├── animated_object/       # Item collectibles (Coin, Chest, Key, Flag, Rune)
│   └── object_and_block/      # Berbagai asset tile dan decoration
│
├── 📁 scenes/                 # Scene files (.tscn)
│   ├── game.tscn              # Main scene - level utama
│   ├── Player_Kurcaci.tscn    # Scene karakter utama
│   ├── Player_Kurcaci_Bullet.tscn  # Scene projectile
│   ├── Enemy_Sekeleton.tscn   # Scene skeleton enemy
│   ├── Enemy_Jamur.tscn       # Scene enemy jamur (optional)
│   ├── checkpoint.tscn        # Scene checkpoint/savepoint
│   ├── killzone.tscn          # Scene hazard zone
│   ├── coin.tscn              # Scene item coin
│   ├── platform.tscn          # Scene platform reusable
│   ├── slime.tscn             # Scene slime enemy
│   ├── goblin.tscn            # Scene goblin enemy
│   ├── trenggiling.tscn       # Scene trenggiling enemy
│   └── player.tscn            # Alternative player scene (legacy)
│
├── 📁 scripts/                # Script files (.gd)
│   ├── Player_Kurcaci_Script.gd    # Logic pemain utama
│   ├── Player_Kurcaci_Bullet_Script.gd # Logic projectile
│   ├── Enemy_Sekeleton_Script.gd   # AI skeleton enemy
│   ├── check_point_manager.gd      # Manager checkpoint system
│   ├── checkpoint.gd               # Checkpoint trigger logic
│   ├── killzone.gd                 # Death zone logic
│   ├── coin.gd                     # Item collection logic
│   ├── goblin.gd                   # AI goblin enemy
│   ├── slime.gd                    # AI slime enemy
│   ├── trenggiling.gd              # AI trenggiling enemy
│   └── player.gd                   # Alternative player script (legacy)
│
├── 📁 demo/                   # Demo files
│   └── thekurcacigames_demo.mp4  # Video demo gameplay
│
└── 📁 .godot/                 # Cache dan data internal Godot
```

### Penjelasan Struktur:

- **assets/** → Semua sprite dan texture diorganisir berdasarkan kategori (karakter, musuh, background, dll)
- **scenes/** → Setiap game object memiliki scene file untuk reusability
- **scripts/** → GDScript logic terpisah dari scene untuk maintainability
- **demo/** → Video demo untuk reference dan testing

---

## 🚀 Cara Menjalankan Project

### Prerequisites

- **Godot 4.3 atau lebih baru** - Download dari [godotengine.org](https://godotengine.org)
- **Operating System** - Windows, macOS, atau Linux

### Step-by-Step

#### 1. **Clone / Extract Project**

```bash
# Jika dari git repository
git clone <repository-url>
cd TheKurcaciGames

# Atau extract jika dari ZIP
```

#### 2. **Buka Project di Godot**

```
- Launch Godot Engine
- Click "Open Project"
- Pilih folder project "TheKurcaciGames"
- Tunggu project terload
```

#### 3. **Jalankan Game**

```
- Klik tombol "Play" (Play Scene) di toolbar atas
- Atau tekan Ctrl+R untuk menjalankan main scene
- Atau tekan Ctrl+Shift+F5 untuk run custom scene
```

#### 4. **Debug / Development**

```
- Buka file tscn/gd apapun untuk editing
- Gunakan Debug Panel untuk inspect objects
- Tekan F6 untuk meng-pause saat runtime
- Tekan F7/F8 untuk step through code
```

### Troubleshooting

| Masalah                   | Solusi                                                                  |
| ------------------------- | ----------------------------------------------------------------------- |
| **Project tidak terload** | Pastikan versi Godot 4.3+, delete `.godot` folder dan reimport          |
| **Missing assets**        | Klik kanan di file explorer → "Reimport"                                |
| **Script errors**         | Lihat Output tab untuk error messages, fix syntax atau reference errors |
| **Game crash**            | Check console untuk null reference exceptions, add debug prints         |

---

## ⌨️ Kontrol Permainan

### Input Mapping (Configurable di project.godot)

| Tombol    | Aksi           | Deskripsi                                     |
| --------- | -------------- | --------------------------------------------- |
| **A**     | Bergerak Kiri  | Gerakkan karakter ke arah kiri                |
| **D**     | Bergerak Kanan | Gerakkan karakter ke arah kanan               |
| **SPACE** | Lompat         | Jump dengan height controllable               |
| **R**     | Serang Melee   | Serangan jarak dekat dengan sword-like weapon |
| **B**     | Serang Range   | Menembak projectile jarak jauh                |

### Kombinasi Aksi

- **Tidak bisa bergerak saat attacking** - Melee atau range attack akan membuat pemain berhenti
- **Tidak bisa attack saat di udara** - Serangan hanya bisa dilakukan saat di floor
- **Jump bisa dilakukan sambil attacking** - Jika sudah mid-jump, bisa attack
- **Attack membatalkan movement** - Velocity.x akan di-reset ke 0

---

## 🎯 Penjelasan Mekanik Game

### A. Sistem Movement

**Physics Engine:**

```gdscript
# Player menggunakan CharacterBody2D dengan velocity system
velocity.y += gravity * delta   # Gravitasi diterapkan setiap frame
move_and_slide()                # Physics processing built-in Godot

const SPEED = 80.0              # Unit/detik
const JUMP_VELOCITY = -310.0    # Negative karena Y-axis pointing down
```

**Kontrol Pemain:**

- Gerak horizontal: `velocity.x = direction * SPEED`
- Jump: `velocity.y = JUMP_VELOCITY` (hanya jika `is_on_floor()`)
- Facing direction diatur dengan flip sprite

### B. Sistem Combat - Melee Attack

**Flow Melee Attack:**

1. Pemain tekan **R**
2. Check: `is_attacking = false` dan `is_on_floor()` → proceed
3. Set `is_attacking = true`
4. Play animation "KurcaciBlock"
5. Enable collision area `attack_shape.disabled = false`
6. Saat collision terdeteksi dengan enemy:
   - Call `enemy.die()` jika ada method tersebut
   - Disable collision area setelah
7. Animasi selesai → signal `animation_finished` → `is_attacking = false`

**Collision Detection:**

```gdscript
func _on_attack_area_area_entered(area: Area2D) -> void:
    var enemy = area.get_parent()
    if is_attacking and enemy.is_in_group("enemy"):
        if enemy.has_method("die"):
            enemy.die()
```

### C. Sistem Combat - Range Attack

**Flow Range Attack:**

1. Pemain tekan **B**
2. Check: `is_range_attacking = false` dan `is_on_floor()` → proceed
3. Set `is_range_attacking = true`
4. Play animation "KurcaciRangeAttack"
5. Start delay timer (0.5 detik)
6. Timer timeout → Instantiate bullet:
   ```gdscript
   var bullet_temp = bullet.instantiate()
   bullet_temp.direction = 1 if not Sprite.flip_h else -1
   bullet_temp.position = global_position
   get_parent().add_child(bullet_temp)
   ```
7. Bullet bergerak dengan `position.x += speed * direction * delta`
8. Bullet check collision dengan raycast atau area
9. Animasi selesai → `is_range_attacking = false`

### D. Sistem Enemy AI

#### **Skeleton Enemy (Advanced)**

**AI Behavior:**

```
State 1: PATROL
├─ Move ke arah tertentu
├─ Check raycast tepi kanan/kiri → jika tidak ada, balik arah
├─ Check raycast dinding → jika ada, balik arah
└─ Continue sampai deteksi pemain

State 2: DETECT PLAYER
├─ Triggered: DetectionArea mendeteksi "Player" group
├─ Set: is_attacking = true
└─ Transition ke ATTACK

State 3: ATTACK
├─ Play animation "SekeletonAttack"
├─ Frame 7: Activate attack collision
├─ Collision terdeteksi → call player.die()
└─ Animasi selesai → back to PATROL

State 4: DIE
├─ Disable semua collider
├─ Play "SekeletonDeadFall" animation
├─ Tunggu animasi finish
└─ Play "SekeletonDead" (static frame) → Queue dari scene
```

**Technical Implementation:**

- **Movement:** `position.x += direction * SPEED * delta`
- **Direction Check:** RayCast2D untuk edge dan wall detection
- **Detection:** Area2D dengan body_entered signal
- **Attack Timing:** Frame-based event dengan `frame_changed` signal

#### **Simple Enemies (Slime, Goblin, Trenggiling)**

**AI Behavior:**

```
Loop:
├─ Check raycast tepi → balik arah jika tidak ada tanah
├─ Check raycast dinding → balik arah jika ada obstacle
├─ Move: position.x += direction * SPEED * delta
└─ Repeat
```

Ketika di-attack → play "dead" animation → queue_free()

### E. Sistem Checkpoint & Respawn

**CheckPointManager:**

```gdscript
class_name CheckPointManager

var last_location  # Menyimpan posisi spawnpoint terakhir
var player

func _ready() -> void:
    player = get_parent().get_node("Player_Kurcaci")
    last_location = player.global_position  # Set awal ke posisi start
```

**Checkpoint Trigger:**

```gdscript
func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("Player"):
        checkpoint_manager.last_location = $RespawnPoint.global_position
    print("save game")
```

**Respawn Trigger (Killzone):**

```gdscript
func killPlayer():
    player.position = checkpoint_manager.last_location  # Teleport ke checkpoint
```

**Flow:**

1. Pemain mulai game → `last_location = posisi awal`
2. Pemain menyentuh checkpoint → update `last_location`
3. Pemain jatuh/masuk killzone → teleport ke `last_location`
4. Health sistem tidak ada (instant respawn)

---

## 📊 Alur Permainan

### Flowchart Gameplay Loop

```
┌─────────────────────────────────────────┐
│      START GAME / RESPAWN               │
│  (Player spawn di start / last checkpoint)
└────────────────┬────────────────────────┘
                 │
                 ▼
        ┌────────────────────┐
        │  INPUT HANDLING    │
        │ (Movement, Attack) │
        └────────┬───────────┘
                 │
        ┌────────▼─────────────┐
        │  UPDATE PHYSICS      │
        │ (Gravity, Collision) │
        └────────┬─────────────┘
                 │
        ┌────────▼──────────────────────────┐
        │  CHECK COLLISION EVENTS           │
        ├──────────────────────────────────┤
        │ - Enemy hit player → DAMAGE       │
        │ - Player hit enemy → ENEMY DIE    │
        │ - Collected coin → SCORE +1       │
        │ - Touchpoint checkpoint → SAVE    │
        │ - Entered killzone → RESPAWN      │
        └────────┬──────────────────────────┘
                 │
        ┌────────▼─────────────────┐
        │  RENDER FRAME            │
        │ (Draw sprites, anim)     │
        └────────┬─────────────────┘
                 │
                 ▼
        ┌──────────────────────┐
        │  PLAYER ALIVE?       │
        └──┬─────────────────┬──┘
        YES│               NO│
           │                └─────┐
           │  (Go back to frame)   │
           └────────────┬──────────┘
           RESPAWN
           Wait → Go back to START
```

### Timeline Event dalam Satu Level

| Event               | Kondisi Trigger              | Aksi Game                          |
| ------------------- | ---------------------------- | ---------------------------------- |
| **Melee Attack**    | Pemain tekan R               | Play attack anim, enable collision |
| **Range Attack**    | Pemain tekan B               | Play anim, spawn projectile        |
| **Enemy Patrol**    | Game loop                    | Musuh bergerak, check detection    |
| **Enemy Attack**    | Player dalam detection area  | Musuh play attack anim             |
| **Collection Coin** | Player collision dengan coin | Coin disappear, score +1           |
| **Checkpoint Save** | Player touch checkpoint      | Update respawn location            |
| **Respawn**         | Player dalam killzone        | Teleport ke last checkpoint        |
| **Death**           | Enemy attack hit player      | Player play dead anim, respawn     |

---

## 🔧 Catatan Penting & Pengembangan

### ✅ Fitur yang Sudah Diimplementasi

- ✓ Player movement dengan physics
- ✓ Melee attack dengan collision detection
- ✓ Range attack dengan projectile spawning
- ✓ Enemy AI dengan patrol dan detection
- ✓ Checkpoint & respawn system
- ✓ Item collection (coins)
- ✓ Animation management
- ✓ Input mapping customizable
- ✓ Group-based object identification

### ❌ Keterbatasan & Bug Potential

| Keterbatasan                      | Deskripsi                                  | Impact                           |
| --------------------------------- | ------------------------------------------ | -------------------------------- |
| **Tidak ada Health System**       | Player langsung mati saat collision        | Tidak ada durability mechanics   |
| **Tidak ada Pause Menu**          | Game terus berjalan tanpa kontrol menu     | UX issue pada gameplay           |
| **Tidak ada Sound/Music**         | Hanya text output untuk events             | Missing audio feedback           |
| **Tidak ada UI Score Display**    | Score hanya di console                     | Player tidak bisa lihat progress |
| **Tidak ada Level Win Condition** | Tidak ada end goal yang jelas              | Game tidak tahu kapan selesai    |
| **Limited Enemy Variety**         | Hanya 4 tipe musuh dengan AI sederhana     | Gameplay bisa repetitif          |
| **Tidak ada Tutorial**            | Pemain harus guess kontrol                 | Steep learning curve             |
| **Physics Glitch**                | Possible corner case di collision handling | Pemain bisa stuck di wall        |

### 🚀 Rencana Pengembangan (Future Roadmap)

#### **Phase 1: Core Polish**

- [ ] Implementasi Health/Lives system
- [ ] Tambah UI Canvas untuk display score, health, lives
- [ ] Buat Pause Menu (resume, quit, settings)
- [ ] Implementasi Level Win Condition dengan level selection

#### **Phase 2: Audio & Feedback**

- [ ] Tambah sound effects (jump, attack, hit, collect)
- [ ] Tambah background music per level
- [ ] Tambah visual effects (particle effects, screen shake)
- [ ] Improve animation smoothing

#### **Phase 3: Content Expansion**

- [ ] Create multiple levels dengan increasing difficulty
- [ ] Design additional enemy types dengan unique AI
- [ ] Add power-ups system (damage boost, speed boost, shield)
- [ ] Implement boss enemy dengan complex attack patterns
- [ ] Add interactive objects (doors, switches, platforms)

#### **Phase 4: Advanced Features**

- [ ] Save system (persistent progress)
- [ ] Leaderboard (score tracking)
- [ ] Difficulty settings
- [ ] Accessibility options (colorblind mode, control rebinding)
- [ ] Mobile controls (touch/gamepad support)

#### **Phase 5: Export & Distribution**

- [ ] Export ke HTML5 untuk web play
- [ ] Export ke Windows .exe
- [ ] Publish di itch.io
- [ ] Optional: Submit ke game platforms

### 📝 Catatan untuk Developer

1. **Performance Optimization**
   - TileMap sudah optimal untuk rendering
   - Jika enemy terlalu banyak, implement object pooling
   - Gunakan RayCast2D sparingly untuk detection

2. **Code Organization**
   - Script dibedakan per functionality (player, enemy, item, manager)
   - Gunakan `@onready` untuk node references
   - Implement proper signal connections di `_ready()`

3. **Debugging Tips**
   - Gunakan `print()` untuk trace event
   - Monitor Physics2D debugger untuk collision issues
   - Inspect nodes di Runtime Inspector untuk check properties
   - Gunakan Breakpoints di GDScript debugger

4. **Best Practices**
   - Selalu check `null` reference sebelum call method
   - Gunakan `call_deferred()` untuk deferred operation (aman dari deletion)
   - Implement proper state machine pattern untuk complex AI
   - Comment code dengan jelas untuk future maintenance

### 📚 Resources & References

- **Godot Documentation**: https://docs.godotengine.org/
- **GDScript Reference**: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/
- **Physics2D Guide**: https://docs.godotengine.org/en/stable/tutorials/2d/physics/index.html
- **Animation System**: https://docs.godotengine.org/en/stable/tutorials/animation/index.html

---

## 👨‍💻 Informasi Project

- **Engine**: Godot 4.3
- **Language**: GDScript
- **Genre**: Platform / Action-Adventure
- **Status**: Active Development
- **Demo Video**: `demo/thekurcacigames_demo.mp4`

---

**Last Updated**: 26 Januari 2026  
**Version**: 1.0 (Prototype)
