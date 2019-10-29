extends Panel

var accum = 0

# Called when the node is added to its parent
func _ready():
	get_node("Button").connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed():
	get_node("Label").text = "YEET!"

func _process(delta):
	accum += delta
	get_node("Label").text = str(accum)
