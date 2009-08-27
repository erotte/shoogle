#findet alle schuhe deren füße schuhe mit gleichen schuhen haben
# erste größe ist der gesuchte schuh
# zweite größe der schuh des fußes des gesuchten schuhs
# dritte größe der schuh des anderen fußes
select s.size, a.model, a.size, b.size from shoes as s, shoes as a, shoes as b
where s.manufacturer = "Adidas"
and s.model = "Adi Racer High"
and a.size = b.size 
and a.model = b.model
and a.manufacturer = b.manufacturer 
and s.foot_id = a.foot_id
and a.foot_id != b.foot_id 
group by a.id;


# mit textausgaben um das ergebnis nachvollziehen zu können
select s.size, sf.email, a.model, a.size, b.size, bf.email from shoes as s, shoes as a, shoes as b, feet as sf, feet as bf 
where s.manufacturer = "Adidas"
and s.model = "Adi Racer High"
and a.size = b.size 
and a.model = b.model
and a.manufacturer = b.manufacturer 
and s.foot_id = a.foot_id
and a.foot_id != b.foot_id 
and s.foot_id = sf.id
and b.foot_id = bf.id 
group by a.id;

# auf einen ausgangsfuß eingeschränkt
# erste größe ist der gesuchte schuh
# zweite größe der schuh des fußes des gesuchten schuhs
# dritte größe der schuh des ausgangs fußes
select s.size, sf.email, a.model, a.size, b.size, bf.email from shoes as s, shoes as a, shoes as b, feet as sf, feet as bf 
where s.manufacturer = "Adidas"
and s.model = "Adi Racer High"
and a.model = b.model
and a.manufacturer = b.manufacturer 
and s.foot_id = a.foot_id
and a.foot_id != b.foot_id 
and s.foot_id = sf.id
and b.foot_id = bf.id
and b.foot_id = #{id};
