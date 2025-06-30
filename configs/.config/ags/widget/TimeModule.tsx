import { GLib, Variable } from "astal"

export function Time({ format = "%m/%d/%Y - %I:%M %p" }) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        cssClasses={["Time"]}
        onDestroy={() => time.drop()}
        label={time()}
    />
}