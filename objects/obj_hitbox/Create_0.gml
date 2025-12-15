if (is_struct(sequence_instance))//if created in sequence, write down it's ID
{
	parent_sequenceID = sequence_instance.elementID;
} else {
	parent_sequenceID = undefined;
}
hp = 100;
maxhp = hp;
if(parent_sequenceID!=undefined){
	seq_inst = layer_sequence_get_instance(parent_sequenceID);
	seq_inst.is_damaged = false;
}
