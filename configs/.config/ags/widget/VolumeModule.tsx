import { bind, Variable } from "astal";
import Wp from "gi://AstalWp"

function setDeviceVolume(device: Wp.Endpoint, volume: number) {

    volume = Math.round(Math.max(0, Math.min(volume * 100, 100))) / 100;
    volume = Math.min(Math.max(0, volume), 1.5);
    device.volume = volume;
}

export function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    const volumePercent = Variable.derive([bind(speaker, 'volume')], v => Math.round(v * 100));

    const volumeLabel = Variable.derive([volumePercent], pct => `${pct}%`);

    return (
        <box cssClasses={["AudioSlider"]}
            onScroll={(_self, dx, dy) => {
                const newVolume = speaker.volume - dy * 0.05;
                setDeviceVolume(speaker, newVolume);
            }}>
            <image iconName={bind(speaker, "volumeIcon")} />
            <label label={volumeLabel()} />
        </box>
    )
}