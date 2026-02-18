CREATE OR REPLACE VIEW public.website_visits_summary_vw
 AS
 SELECT count(*) FILTER (WHERE "visitedAt"::date = CURRENT_DATE) AS today_visits,
    count(*) FILTER (WHERE "visitedAt" >= date_trunc('week'::text, CURRENT_DATE::timestamp with time zone)) AS this_week_visits,
    count(*) FILTER (WHERE "visitedAt" >= date_trunc('month'::text, CURRENT_DATE::timestamp with time zone)) AS this_month_visits,
    count(*) FILTER (WHERE "visitedAt" >= date_trunc('year'::text, CURRENT_DATE::timestamp with time zone)) AS this_year_visits
   FROM "websiteVisit";
 -------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW public.leaders_vw
 AS
 SELECT ldt.level,
    ldt.title,
    ldt."titleDesc",
    ld."leaderID",
    ld.prefix,
    concat(ld.fname, ' ', ld."midName", ' ', ld.surname) AS fullname,
    ld.email,
    ld.phone,
    ld.bio,
    ld.status,
    ld.profile_pic_path,
    ld.linkedin_acc,
    ld.fb_acc,
    ld.twitter_acc,
    ld.instagram_acc,
    ld."createdAt"
   FROM leaders ld
     RIGHT JOIN "leadersTitle" ldt ON ldt."leadersTitleID" = ld."leadersTitleID";
