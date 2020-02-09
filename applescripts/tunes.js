function getApplication(application_name) {
	try {
		return Application(application_name);
	} catch (e) {
		return null;
	}
}

let output = "";

let app = getApplication("Music");
if (app && app.running()) {
    const track = app.track;
    const artist = track.artist;
    const title = track.name;
    output = `${title} - ${artist}`.substr(0, 50);
}

app = getApplication("Spotify");
if (app && app.running()) {
    const track = app.currentTrack;
    const artist = track.artist();
    const title = track.name();
    output = `${title} - ${artist}`.substr(0, 50);
}

output;
