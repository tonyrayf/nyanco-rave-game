if (hp <= 0) {
	if(parent_sequenceID==undefined){//if NOT created in sequence
		instance_destroy();
	} else {
		layer_sequence_destroy(parent_sequenceID);//or destroy complete sequence
	}
} else if (hp<maxhp){
	seq_inst.is_damaged = true;
}