export function capitalize(str) {
    if (!str) return '';

    str = str.trim();
    return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
};


export function  getTrimmedSentence (text, maxLength = 50){

  if (!text) return '';

  // Match the first sentence ending with . ! or ?
  const sentenceMatch = text.match(/[^.!?]+[.!?]/);
  const sentence = sentenceMatch ? sentenceMatch[0].trim() : text.trim();

  // If sentence is longer than maxLength, trim and add "..."
  if (sentence.length > maxLength) {
    return sentence.slice(0, maxLength).trim() + '...';
  }

  return sentence;
};