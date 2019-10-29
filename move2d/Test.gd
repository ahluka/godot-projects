extends TextureRect
class_name TestClass, "res://icon.png"
export(int, "Warrior", "Magician", "Thief") var character_class

func _init():
	texture = ImageTexture.new()
	texture.load("res://icon.png")
	
