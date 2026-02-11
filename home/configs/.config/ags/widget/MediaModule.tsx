import { bind } from "astal";
import Mpris from "gi://AstalMpris";

export function Media() {
  const mpris = Mpris.get_default();

  const getSpotify = (players: Mpris.Player[]) => {
    for (const player of players) {
      if (player.busName?.toLowerCase().includes("spotify")) {
        return player;
      }
    }
    return null;
  };

  return (
    <box
      children={bind(mpris, "players").as(players => {
        const spotify = getSpotify(players);
        if (!spotify) return [];

        // Return a single-element array: one <box> whose children
        // also come from a Binding<Widget[]>.
        return [
          <box
            cssClasses={["Media"]}
            children={bind(spotify, "metadata").as(() => {
              // Now this .as returns Widget[] instead of a single Widget
              return [
                // First the Spotify icon
                <label label="" />,
                // Then the artist–title text
                <label
                  label={`${spotify.artist ?? "Unknown Artist"} - ${spotify.title ?? "Unknown Title"}`}
                />
              ];
            })}
          />
        ];
      })}
    />
  );
}
