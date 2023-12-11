extends Node2D

var title_music = load("res://assets/Sounds/OST/Title_Screen.ogg")
var level1_music = load("res://assets/Sounds/OST/Ahoy! [fight].ogg")
var credits = load("res://assets/Sounds/OST/Fishing Docks 08PM [credits].mp3")
var how = load("res://assets/Sounds/OST/Fish Bucket [character screen].mp3")

func play_music():
	$Music.stream = title_music
	# $Music.play()

func stop_music():
	$Music.stop()

func level1():
	$Music.stream = level1_music
	# $Music.play()

func play_credits():
	$Music.stream = credits
	$Music.play()

func play_how():
	$Music.stream = how
	$Music.play()
