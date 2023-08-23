with joined as (select {0}, age, gender, tag1, tag2, tag3
                from SALES s
                         join MODEL m on s.model_id = m.id
                where m.trim_id = 1
                )

select {0}       as id,
       count({0}) as select_count
from joined
WHERE (
            (:tag1, :tag2, :tag3) in ((tag1, tag2, tag3),
                                      (tag1, tag3, tag2),
                                      (tag2, tag1, tag3),
                                      (tag2, tag3, tag1),
                                      (tag3, tag1, tag2),
                                      (tag3, tag2, tag1)
            )
        and (
                    (:age <= age <= :age+9 and gender != :gender)
                    or ((:age < age or age >= :age+9) and gender = :gender)
                    or (:age <= age < :age+9 and gender = :gender)
                )
    )
   or (
                    :age <= age < :age+9
        and gender = :gender
        and (
                            (:tag1, :tag2) in ((tag1, tag2), (tag1, tag3),
                                               (tag2, tag1), (tag2, tag3),
                                               (tag3, tag1), (tag3, tag2))
                        or
                            (:tag1, :tag3) in ((tag1, tag2), (tag1, tag3),
                                               (tag2, tag1), (tag2, tag3),
                                               (tag3, tag1), (tag3, tag2))
                        or
                            (:tag2, :tag3) in ((tag1, tag2), (tag1, tag3),
                                               (tag2, tag1), (tag2, tag3),
                                               (tag3, tag1), (tag3, tag2))
                    )
        and (:tag1, :tag2, :tag3) not in (
                                          (tag1, tag2, tag3),
                                          (tag1, tag3, tag2),
                                          (tag2, tag1, tag3),
                                          (tag2, tag3, tag1),
                                          (tag3, tag1, tag2),
                                          (tag3, tag2, tag1)
        )
    )
group by :targetId
with rollup