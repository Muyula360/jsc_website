
'use strict';

module.exports = {

  up: async (queryInterface, Sequelize) => {

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.annoncements_vw AS
      SELECT an."announcementID",
          an."announcementTitle",
          an."announcementDesc",
          an."hasAttachment",
          concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
          usr."worktStation",
          an."postedAt",
          an."attachmentPath"
        FROM announcements an
        JOIN "user" usr ON usr."userID" = an."userID";
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.billboards_vw AS
      SELECT bl."billboardID", 
        bl."billboardTitle", 
        bl."billboardBody", 
        bl."showOnCarouselDisplay", 
        bl."billboardPhotoPath", 
        concat(usr.userfname, ' ', usr."userSurname") AS "postedBy", 
        usr."worktStation", bl."postedAt"
      FROM public.billboards bl
      JOIN "user" usr ON usr."userID" = bl."userID";
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.contenthighlights_vw AS
      SELECT ( SELECT count(*) AS count
                FROM newsupdates) AS news,
          ( SELECT count(*) AS count
                FROM announcements) AS announcements,
          ( SELECT count(*) AS count
                FROM newsletter) AS newsletters,
          ( SELECT count(*) AS count
                FROM tenders) AS tenders,
          ( SELECT count(*) AS count
                FROM vacancies) AS vacancies,
          ( SELECT count(*) AS count
      FROM feedbacks) AS feedbacks;
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.gallery_vw AS
      SELECT gl."galleryID",
          gl."albumTitle",
          concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
          usr."worktStation",
          gl."albumPhotoCount",
          gl."albumCoverPhotoPath",
          gl."albumPhotosPaths",
          gl."postedAt"
        FROM gallery gl
        JOIN "user" usr ON usr."userID" = gl."userID";
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.leaders_vw AS
      SELECT ldt.level,
          ldt."leadersTitleID",
          ldt.title,
          ldt."titleDesc",
          ld."leaderID",
          ld.prefix,
          ld.fname,
          ld."midName",
          ld.surname,
          concat(ld.fname, ' ', ld."midName", ' ', ld.surname) AS fullname,
          ld.email,
          ld.phone,
          ld.profession,
          ld."experienceYears",
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
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.newsletter_vw AS
      SELECT nl."newsletterID",
        nl."newsletterNo",
        nl."newsletterYear",
        nl."newsletterMonth",
        concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
        usr."worktStation",
        nl."newsletterCoverPath",
        nl."newsletterPath",
        nl.downloads,
        nl.reads,
        nl."postedAt"
      FROM newsletter nl
      JOIN "user" usr ON usr."userID" = nl."userID";
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.newsupdates_vw AS
      SELECT nw."newsupdatesID",
          nw."newsTitle",
          nw."newsDesc",
          concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
          usr."worktStation",
          nw."postedAt",
          nw."coverPhotoPath",
          nw."supportingPhotosPaths"
      FROM newsupdates nw
      JOIN "user" usr ON usr."userID" = nw."userID";
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.publications_vw AS
      SELECT pb."publicationsID",
          pb.category,
          pb.title,
          concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
          usr."worktStation",
          pb."contentType",
          pb."contentSize",
          pb."contentPath",
          pb."createdAt"
        FROM publications pb
        JOIN "user" usr ON usr."userID" = pb."userID";
    `);


    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.tenders_vw AS
      SELECT td."tenderID",
          td."userID",
          td."tenderNum",
          td."tenderTitle",
          td."tenderDesc",
          td.tenderer,
          td."openDate",
          td."closeDate",
          concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
          usr."worktStation",
          td."hasAttachment",
          td."attachmentPath",
          td.link,
          td."postedAt"
        FROM tenders td
        JOIN "user" usr ON usr."userID" = td."userID";
    `);


    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.vacancies_vw AS
      SELECT vc."vacancyID",
          vc."vacancyTitle",
          vc."vacancyDesc",
          vc."vacantPositions",
          vc."openDate",
          vc."closeDate",
          concat(usr.userfname, ' ', usr."userSurname") AS "postedBy",
          usr."worktStation",
          vc."hasAttachment",
          vc."attachmentPath",
          vc.link,
          vc."postedAt"
        FROM vacancies vc
        JOIN "user" usr ON usr."userID" = vc."userID";
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.website_visits_summary_vw AS
      SELECT count(*) FILTER (WHERE "visitedAt"::date = CURRENT_DATE) AS today_visits,
          count(*) FILTER (WHERE "visitedAt" >= date_trunc('week'::text, CURRENT_DATE::timestamp with time zone)) AS this_week_visits,
          count(*) FILTER (WHERE "visitedAt" >= date_trunc('month'::text, CURRENT_DATE::timestamp with time zone)) AS this_month_visits,
          count(*) FILTER (WHERE "visitedAt" >= date_trunc('year'::text, CURRENT_DATE::timestamp with time zone)) AS this_year_visits
      FROM "websiteVisit";
    `);

    await queryInterface.sequelize.query(`
      CREATE OR REPLACE VIEW public.weeklyvisittrend_vw AS
      SELECT date("visitedAt") AS visit_date,
          count(*) AS total_visits
      FROM "websiteVisit"
      WHERE "visitedAt" >= (CURRENT_DATE - '9 days'::interval)
      GROUP BY (date("visitedAt"))
      ORDER BY (date("visitedAt"));
    `);

  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS annoncements_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS contenthighlights_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS leaders_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS gallery_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS newsletter_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS newsupdates_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS publications_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS tenders_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS vacancies_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS website_visits_summary_vw;`);
    await queryInterface.sequelize.query(`DROP VIEW IF EXISTS weeklyvisittrend_vw;`);
  }

};


// npx sequelize db:migrate