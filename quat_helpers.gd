class_name QuatHelpers

static func localise_rotation(to_localise : Quat, relative_to : Quat) -> Quat:
	return (relative_to.inverse() * to_localise).normalized()