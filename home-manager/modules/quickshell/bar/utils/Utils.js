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
  if (!Number.isFinite(current) || !Number.isFinite(total) || total <= 0) {
    return 0;
  }
  return Math.round(Math.max(0, Math.min((current / total) * 100, 100)));
}

function kbytesToHumanReadable(kibibytes) {
  return (kibibytes / 1048576).toFixed(2);
}

function getBinValue(bins, ratio) {
  if (!bins || bins.length === 0) {
    return ""
  }
  const normalizedRatio = Number.isFinite(ratio) ? Math.max(0, Math.min(ratio, 1)) : 0
  let bin = Math.min(bins.length - 1, Math.floor(normalizedRatio * bins.length))
  return bins[bin]
}
