# Tutorial 3 - GameDev Fasilkom UI 2022/2023 - Genap

## Robertus Aditya Sukoco - 2006523016

Berikut adalah source code yang digunakan untuk mengimplementasi mekanisme lompat pada player

```py
if is_on_floor() and Input.is_action_just_pressed('up'):
    animation.play("jump")
    velocity.y = jump_speed
```

Namun, _source code_ tersebut mengakibatkan player tidak bisa lompat di tengah udara. Agar player bisa lompat di tengah udara (maksimal satu kali), kita perlu membuat sebuah _boolean flag_, disini saya menamakannya `double_jump_available`. Berikut implementasi _double jump_:

```py
if is_on_floor() and Input.is_action_just_pressed('up'):
    animation.play("jump")
    velocity.y = jump_speed

elif double_jump_available and Input.is_action_just_pressed('up'):
    velocity.y = jump_speed
    double_jump_available = false
```

Setelah itu, kita perlu mengubah nilai _flag_ `double_jump_available` kembali menjadi `true` saat player sudah mendarat. Berikut _source code_ nya:

```py
if not is_on_floor():
    animation.play("jump")
else:
    double_jump_available = true
```

Implementasi penuh dari mekanisme _player movement_ dapat dilihat di `res://scenes/Player.gd`
<br>
<br>
<br>

### References
1. https://forum.godotengine.org/t/why-is-on-floor-always-returns-false/6801
2. https://forum.godotengine.org/t/double-jump-help/16175