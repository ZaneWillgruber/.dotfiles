import { App, Astal, Gdk } from "astal/gtk4"
import { Time } from "./TimeModule"
import { Workspaces } from "./WorkspaceModule"
import { Wifi } from "./NetworkModule"
import { AudioSlider } from "./VolumeModule"
import { Media } from "./MediaModule"
import { System } from "./SystemModule"
import { CpuModule } from "./CpuModule"
import { MemoryIndicator } from "./MemoryModule"
import { ArchLogo } from "./ArchModule"
import { SystemTray } from "./TrayModule"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return (
        <window
            visible
            cssClasses={["Bar"]}
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={App}
            child={
                <centerbox
                    cssName="centerbox"
                    startWidget={
                        <box
                            children={[
                                <box
                                    cssClasses={["padding-8"]}
                                    children={[
                                        <ArchLogo />,
                                        <Workspaces />,
                                        <SystemTray />,
                                        <Media />
                                    ]}
                                />
                            ]}
                        />
                    }
                    centerWidget={
                        <box
                            cssClasses={["padding-8"]}
                            children={[
                                <Time />
                            ]}
                        />
                    }
                    endWidget={
                        <box
                            cssClasses={["padding-8"]}
                            children={[
                                <MemoryIndicator />,
                                <CpuModule />,
                                <Wifi />,
                                <AudioSlider />,
                                <System />
                            ]}
                        />
                    }
                />
            }
        />
    )
}
