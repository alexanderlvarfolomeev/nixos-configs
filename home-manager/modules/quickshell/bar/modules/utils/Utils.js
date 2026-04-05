function secondsToHumanReadable(totalSeconds) {
  const hours = Math.floor(totalSeconds / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;
  if (hours > 0) {
    return hours + " h " + minutes + " min"
  }
  if (minutes > 0) {
    return minutes + " min " + seconds + " s"
  }
  return seconds + " s"
}

function percentage(current, total) {
  if (total == 0) {
    return 0;
  }
  return Math.round(Math.min((current / total) * 100, 100));
}

function kbytesToHumanReadable(kibibytes) {
  return (kibibytes / 1048576).toFixed(2);
}