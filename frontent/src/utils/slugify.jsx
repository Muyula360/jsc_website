export const slugify = (text) =>
  text
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')   // replace non-alphanumeric with dashes
    .replace(/^-+|-+$/g, '');      // trim leading/trailing dashes
