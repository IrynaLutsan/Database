from app.my_project import db
from app.my_project.dao.models import Users, NotificationSettings, SystemNotifications, Objects
from app.my_project.dto.schemas import users_schema, user_schema, object_schema

def get_all_users():
    all_users = Users.query.all()
    
    return users_schema.dump(all_users)

def get_user_by_id(user_id):

    user = Users.query.get_or_404(user_id) 
    return user_schema.dump(user)

def create_user(data):
    
    new_user = user_schema.load(data, session=db.session)
    
    db.session.add(new_user)
    
    db.session.commit()
    
    return user_schema.dump(new_user)

def update_user(user_id, data):
    
    user = Users.query.get_or_404(user_id)
    
    user = user_schema.load(data, instance=user, session=db.session, partial=True)
    db.session.add(user)
    db.session.commit()
    return user_schema.dump(user)

def delete_user(user_id):
    user = Users.query.get_or_404(user_id)

    NotificationSettings.query.filter_by(user_id=user_id).delete()

    SystemNotifications.query.filter_by(user_id=user_id).delete()

    db.session.delete(user)

    db.session.commit()

    return "", 204

def get_object_by_id(object_id):
    obj = Objects.query.get_or_404(object_id)

    return object_schema.dump(obj)

def get_users_for_object(object_id):
    obj = Objects.query.get_or_404(object_id)

    users_list = obj.users_with_access

    return users_schema.dump(users_list)