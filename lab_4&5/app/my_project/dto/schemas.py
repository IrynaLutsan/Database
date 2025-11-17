from app.my_project import ma
from app.my_project.dao.models import Users, Objects, Zones 

class UserSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Users
        load_instance = True 

    password_hash = ma.auto_field(load_only=True)

user_schema = UserSchema()
users_schema = UserSchema(many=True)

class ZoneSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Zones
        load_instance = True
        include_fk = True 
        
zone_schema = ZoneSchema()
zones_schema = ZoneSchema(many=True)


class ObjectSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Objects
        load_instance = True
        include_relationships = True 

    zones = ma.Nested(zones_schema, many=True)

object_schema = ObjectSchema()
objects_schema = ObjectSchema(many=True)