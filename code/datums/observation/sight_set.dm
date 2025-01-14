//	Observer Pattern Implementation: Sight Set
//		Registration type: /mob
//
//		Raised when: A mob's sight value changes.
//
//		Arguments that the called proc should expect:
//			/mob/sightee:  The mob that had its sight set
//			/old_sight: sight before the change
//			/new_sight: sight after the change

/decl/observ/sight_set
	name = "Sight Set"
	expected_type = /mob

/*********************
* Sight Set Handling *
*********************/

/mob/proc/set_sight(var/new_sight)
	var/old_sight = sight
	if(!(new_sight & (SEE_MOBS|SEE_OBJS|SEE_TURFS)))
		new_sight |= SEE_BLACKNESS // Avoids pixel bleed from atoms overlapping completely dark turfs, but conflicts with other flags.
	if(old_sight != new_sight)
		sight = new_sight
		events_repository.raise_event(/decl/observ/sight_set, src, old_sight, new_sight)
