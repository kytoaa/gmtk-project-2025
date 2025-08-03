extends Node

const LossReason = GameData.LossReason

signal on_player_loss
signal on_dealer_loss
signal on_game_end(LossReason)

signal continue_game
signal go_to_shop

signal on_scene_transition_finished
signal on_scene_transition_fade_to_black

signal player_turn_start
signal opponent_turn_start
signal return_cards_start
