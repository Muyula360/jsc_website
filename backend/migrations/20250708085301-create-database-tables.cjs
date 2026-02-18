//npx sequelize-cli migration:generate --name create-database-tables

'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
     await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public."user"
      (
          "userID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "worktStation" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "userEmail" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          userfname character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "userMidname" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "userSurname" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "userPassword" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "userRole" character varying(30) COLLATE pg_catalog."default" NOT NULL,
          "userProfilePicPath" character varying(225) COLLATE pg_catalog."default" DEFAULT 'Not Attached'::character varying,
          "userVerfication" integer NOT NULL DEFAULT 0,
          "userStatus" character varying(30) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Active'::character varying,
          "userCreatedAt" timestamp with time zone,
          CONSTRAINT "user_userEmail_key" UNIQUE ("userEmail")
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.announcements
      (
        "announcementID" BIGSERIAL PRIMARY KEY,
        "UUID" UUID,
        "userID" INTEGER NOT NULL,
        "announcementTitle" VARCHAR(225) NOT NULL,
        "announcementDesc" TEXT NOT NULL,
        "hasAttachment" INTEGER NOT NULL DEFAULT 0,
        "attachmentPath" VARCHAR(225) NOT NULL DEFAULT 'N/A',
        "postedAt" TIMESTAMPTZ,
        CONSTRAINT "announcements_userID_fkey" FOREIGN KEY ("userID")
            REFERENCES public."user" ("userID")
            ON UPDATE CASCADE
            ON DELETE CASCADE
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.speeches
      (
        "announcementID" BIGSERIAL PRIMARY KEY,
        "UUID" UUID,
        "userID" INTEGER NOT NULL,
        "announcementTitle" VARCHAR(225) NOT NULL,
        "announcementDesc" TEXT NOT NULL,
        "hasAttachment" INTEGER NOT NULL DEFAULT 0,
        "attachmentPath" VARCHAR(225) NOT NULL DEFAULT 'N/A',
        "postedAt" TIMESTAMPTZ,
        CONSTRAINT "announcements_userID_fkey" FOREIGN KEY ("userID")
            REFERENCES public."user" ("userID")
            ON UPDATE CASCADE
            ON DELETE CASCADE
      )
    `);


   await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.billboards
      (
          "billboardID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          "billboardTitle" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "billboardBody" text COLLATE pg_catalog."default" NOT NULL,
          "showOnCarouselDisplay" boolean NOT NULL DEFAULT true,
          "billboardPhotoPath" character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          "postedAt" timestamp with time zone
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.feedbacks
      (
          "feedbackID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "submitterEmail" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "submitterName" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "feedbackSubject" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "feedbackBody" text COLLATE pg_catalog."default" NOT NULL,
          "createdAt" timestamp with time zone
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public."feedbacksReview"
      (
          "feedbackReviewID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "feedbackID" integer NOT NULL,
          "userID" integer NOT NULL,
          comments text COLLATE pg_catalog."default" NOT NULL DEFAULT 'Nill'::text,
          "createdAt" timestamp with time zone,
          CONSTRAINT "feedbacksReview_feedbackID_fkey" FOREIGN KEY ("feedbackID")
              REFERENCES public.feedbacks ("feedbackID") MATCH SIMPLE
              ON UPDATE CASCADE
              ON DELETE CASCADE
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.gallery
      (
          "galleryID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          "albumTitle" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "albumPhotoCount" integer NOT NULL DEFAULT 0,
          "albumCoverPhotoPath" character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          "albumPhotosPaths" character varying(255)[] COLLATE pg_catalog."default" DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
          "postedAt" timestamp with time zone
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.leaders
      (
          "leaderID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          "leadersTitleID" integer NOT NULL,
          fname character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "midName" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          surname character varying(225) COLLATE pg_catalog."default" NOT NULL,
          prefix character varying(50) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          email character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          profession character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "experienceYears" integer NOT NULL DEFAULT 0,
          phone character varying(50) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          profile_pic_path character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          bio text COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::text,
          linkedin_acc character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          fb_acc character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          twitter_acc character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          instagram_acc character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          status character varying(30) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Active'::character varying,
          "createdAt" timestamp with time zone,
          CONSTRAINT "leaders_userID_fkey" FOREIGN KEY ("userID")
              REFERENCES public."user" ("userID") MATCH SIMPLE
              ON UPDATE CASCADE
              ON DELETE CASCADE
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public."leadersTitle"
      (
          "leadersTitleID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          title character varying(255) COLLATE pg_catalog."default" NOT NULL,
          level integer NOT NULL,
          "titleDesc" text COLLATE pg_catalog."default",
          "createdAt" timestamp with time zone NOT NULL,
          "updatedAt" timestamp with time zone,
          CONSTRAINT "leadersTitle_title_key" UNIQUE (title)
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.newsletter
      (
          "newsletterID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          "newsletterNo" integer NOT NULL,
          "newsletterYear" integer NOT NULL,
          "newsletterMonth" character varying(60) COLLATE pg_catalog."default" NOT NULL,
          "newsletterCoverPath" character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          "newsletterPath" character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          downloads integer NOT NULL DEFAULT 0,
          reads integer NOT NULL DEFAULT 0,
          "postedAt" timestamp with time zone,
          CONSTRAINT "newsletter_userID_fkey" FOREIGN KEY ("userID")
              REFERENCES public."user" ("userID") MATCH SIMPLE
              ON UPDATE CASCADE
              ON DELETE CASCADE
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.newsupdates
      (
          "newsupdatesID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          "newsTitle" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "newsDesc" text COLLATE pg_catalog."default" NOT NULL,
          "showOnCarouselDisplay" boolean NOT NULL DEFAULT false,
          "coverPhotoPath" character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          "supportingPhotosPaths" character varying(255)[] COLLATE pg_catalog."default" DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
          "postedAt" timestamp with time zone,
          CONSTRAINT "newsupdates_userID_fkey" FOREIGN KEY ("userID")
              REFERENCES public."user" ("userID") MATCH SIMPLE
              ON UPDATE CASCADE
              ON DELETE CASCADE
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.notifications
      (
          "notificationID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "notificationTitle" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "notificationDesc" text COLLATE pg_catalog."default" NOT NULL,
          "broadcastScope" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "createdAt" timestamp with time zone
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.publications
      (
          "publicationsID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          category character varying(30) COLLATE pg_catalog."default" NOT NULL,
          title character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "contentType" character varying(30) COLLATE pg_catalog."default",
          "contentSize" integer,
          "contentPath" character varying(225) COLLATE pg_catalog."default",
          "createdAt" timestamp with time zone
      )
    `);

    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.tenders
      (
          "tenderID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          "tenderNum" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "tenderTitle" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "tenderDesc" text COLLATE pg_catalog."default" NOT NULL DEFAULT 'N/A'::text,
          tenderer character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "openDate" timestamp with time zone NOT NULL,
          "closeDate" timestamp with time zone NOT NULL,
          "hasAttachment" integer NOT NULL DEFAULT 0,
          "attachmentPath" character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          link character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          "postedAt" timestamp with time zone
      )
    `);


    await queryInterface.sequelize.query(`
      CREATE TABLE IF NOT EXISTS public.vacancies
      (
          "vacancyID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          "userID" integer NOT NULL,
          "vacancyTitle" character varying(225) COLLATE pg_catalog."default" NOT NULL,
          "vacancyDesc" text COLLATE pg_catalog."default" NOT NULL,
          "vacantPositions" integer NOT NULL,
          "openDate" timestamp with time zone NOT NULL,
          "closeDate" timestamp with time zone NOT NULL,
          "hasAttachment" integer NOT NULL DEFAULT 0,
          "attachmentPath" character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          link character varying(225) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Not Attached'::character varying,
          "postedAt" timestamp with time zone
      )
    `);

    await queryInterface.sequelize.query(`
     CREATE TABLE IF NOT EXISTS public."websiteVisit"
      (
          "visitID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          ip_address character varying(255) COLLATE pg_catalog."default",
          user_agent character varying(255) COLLATE pg_catalog."default",
          referrer character varying(500) COLLATE pg_catalog."default",
          page_url character varying(255) COLLATE pg_catalog."default",
          session_id character varying(255) COLLATE pg_catalog."default",
          device_type character varying(225) COLLATE pg_catalog."default",
          browser character varying(225) COLLATE pg_catalog."default" DEFAULT 'unknown'::character varying,
          os character varying(225) COLLATE pg_catalog."default" DEFAULT 'unknown'::character varying,
          screen_resolution character varying(225) COLLATE pg_catalog."default" DEFAULT '0x0'::character varying,
          country character varying(225) COLLATE pg_catalog."default" DEFAULT 'unknown'::character varying,
          city character varying(255) COLLATE pg_catalog."default" DEFAULT 'unknown'::character varying,
          language character varying(255) COLLATE pg_catalog."default" DEFAULT 'unknown'::character varying,
          is_bot character varying(255) COLLATE pg_catalog."default",
          "visitedAt" timestamp with time zone
      )
    `);

    await queryInterface.sequelize.query(`
     CREATE TABLE IF NOT EXISTS public."regions"
      (
          "regionID" BIGSERIAL PRIMARY KEY,
          "UUID" uuid,
          regionName character varying(255) COLLATE pg_catalog."default",
          regionCode character varying(50) COLLATE pg_catalog."default",
          "createdAt" timestamp with time zone
      )
    `);
  },

  async down (queryInterface, Sequelize) {
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public."websiteVisit" CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.vacancies CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.tenders CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.publications CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.notifications CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.newsupdates CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.newsletter CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public."leadersTitle" CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.leaders CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.gallery CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public."feedbacksReview" CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.feedbacks CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.billboards CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.announcements CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public.speeches CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public."user" CASCADE;`);
      await queryInterface.sequelize.query(`DROP TABLE IF EXISTS public."regions" CASCADE;`);
    }
  
};

// npx sequelize db:migrate
