import multer from 'multer';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);


// directories
const websiteRepositoryDir = path.join(__dirname, '../website-repository');
const userDPDir = path.join(websiteRepositoryDir, 'users');
const billboardsDir = path.join(websiteRepositoryDir, 'billboards');
const announcementDir = path.join(websiteRepositoryDir, 'announcements');
const newsUpdatesDir = path.join(websiteRepositoryDir, 'newsupdates');
const newsletterDir = path.join(websiteRepositoryDir, 'newsletter');
const leadersProfilePicDir = path.join(websiteRepositoryDir, 'leadersprofilepictures');
const vacanciesDir = path.join(websiteRepositoryDir, 'vacancies');
const publicationsDir = path.join(websiteRepositoryDir, 'publications');
const galleryDir = path.join(websiteRepositoryDir, 'gallery');


// Create Website Repository if doesn't exist
const ensureDirectoryExists = (websiteRepositoryDir) => {
    if (!fs.existsSync(websiteRepositoryDir)) {
        fs.mkdirSync(websiteRepositoryDir, { recursive: true });
    }
};


// User display picture storage configuration
const userDPStorage = multer.diskStorage({
    destination: (req, file, cb) => {
      ensureDirectoryExists(userDPDir);
      cb(null, userDPDir);
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
      cb(null, `userDP-${uniqueSuffix}${path.extname(file.originalname)}`);
    }
});


// Billboard picture storage configuration
const billboardPicturesStorage = multer.diskStorage({
    destination: (req, file, cb) => {
      ensureDirectoryExists(billboardsDir);
      cb(null, billboardsDir);
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
      cb(null, `billboard-${uniqueSuffix}${path.extname(file.originalname)}`);
    }
});


// Announcement attachment storage configuration
const announcementAttachmentsStorage = multer.diskStorage({
    destination: (req, file, cb) => {
      ensureDirectoryExists(announcementDir);
      cb(null, announcementDir);
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
      cb(null, `announcement-${uniqueSuffix}${path.extname(file.originalname)}`);
    }
});

// news photo storage configuration
const newsAttachmentsStorage = multer.diskStorage({
    destination: (req, file, cb) => {
      ensureDirectoryExists(newsUpdatesDir);
      cb(null, newsUpdatesDir);
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);

      if (file.fieldname === "newsPhotos"){

        cb(null, `newsPhoto-${uniqueSuffix}${path.extname(file.originalname)}`);

      } else if (file.fieldname === "newsCoverPhoto"){

        cb(null, `newsCoverPhoto-${uniqueSuffix}${path.extname(file.originalname)}`);
      }    
    }
});


// newsletter cover storage configuration
const newsletterAttachmentsStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    ensureDirectoryExists(newsletterDir);
    cb(null, newsletterDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);

    if (file.fieldname === "newsletterCover"){

      cb(null, `newsletterCover-${uniqueSuffix}${path.extname(file.originalname)}`);

    } else if (file.fieldname === "newsletterAttachment"){

      cb(null, `newsletter-${uniqueSuffix}${path.extname(file.originalname)}`);
    }    
  }
});


// leader Profile Picture storage configuration
const leadersProfilePicStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    ensureDirectoryExists(leadersProfilePicDir);
    cb(null, leadersProfilePicDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, `leaderProfilePic-${uniqueSuffix}${path.extname(file.originalname)}`);
  }
});


// vacancy storage configuration
const vacancytAttachmentsStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    ensureDirectoryExists(vacanciesDir);
    cb(null, vacanciesDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, `vacancy-${uniqueSuffix}${path.extname(file.originalname)}`);
  }
});


// Publications storage configuration
const publicContentAttachmentsStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    ensureDirectoryExists(publicationsDir);
    cb(null, publicationsDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, `publication-${uniqueSuffix}${path.extname(file.originalname)}`);
  }
});


// gallery storage configuration
const galleyPhotoStorage = multer.diskStorage({
    destination: (req, file, cb) => {
      ensureDirectoryExists(galleryDir);
      cb(null, galleryDir);
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);

      if (file.fieldname === "albumPhotos"){

        cb(null, `galleryPhoto-${uniqueSuffix}${path.extname(file.originalname)}`);

      } else if (file.fieldname === "albumCoverPhoto"){

        cb(null, `galleryCoverPhoto-${uniqueSuffix}${path.extname(file.originalname)}`);
      }    
    }
});




// Filter file types
const fileFilter = (req, file, cb) => {
    const allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/gif'];
    if (allowedTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type. Only PDF and images are allowed'), false);
    }
};


// user display picture upload instances
const uploadUserDP = multer({
    storage: userDPStorage,
    fileFilter: fileFilter,
    limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
});


// billboard upload instances
const uploadBillboard = multer({
    storage: billboardPicturesStorage,
    fileFilter: fileFilter,
    limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
});

// announcement upload instances
const uploadAnnouncement = multer({
    storage: announcementAttachmentsStorage,
    fileFilter: fileFilter,
    limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
});

// news upload instances
const uploadNews = multer({
    storage: newsAttachmentsStorage,
    fileFilter: fileFilter,
    limits: { fileSize: 1024 * 1024 * 25, }, // limit 5MB
})

// newsletter upload instances
const uploadNewsletter = multer({
  storage: newsletterAttachmentsStorage,
  fileFilter: fileFilter,
  limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
})

// leaders profile picture upload instances
const uploadLeaderProfilePic = multer({
  storage: leadersProfilePicStorage,
  fileFilter: fileFilter,
  limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
});

// vacancies upload instances
const uploadVacancy = multer({
  storage: vacancytAttachmentsStorage,
  fileFilter: fileFilter,
  limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
});


// publication upload instances
const uploadPublicContent = multer({
  storage: vacancytAttachmentsStorage,
  fileFilter: fileFilter,
  limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
});


// gallery upload instances
const uploadGalleryPhotos = multer({
  storage: galleyPhotoStorage,
  fileFilter: fileFilter,
  limits: { fileSize: 1024 * 1024 * 5, }, // limit 5MB
});







export { uploadUserDP, uploadBillboard, uploadAnnouncement, uploadNews, uploadNewsletter, uploadLeaderProfilePic, uploadVacancy, uploadPublicContent, uploadGalleryPhotos }