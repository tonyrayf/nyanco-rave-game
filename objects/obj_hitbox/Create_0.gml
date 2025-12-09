hp = 100;
if (is_struct(sequence_instance))//if created in sequence, write down it's ID
{
	parent_sequenceID = sequence_instance.elementID;
} else {
	parent_sequenceID = undefined;
}
