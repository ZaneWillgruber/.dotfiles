import { bind, execAsync } from "astal";
import { cpuUsage } from "../utils/system-stats";
import { BarComponent } from "./BarComponent";

export function CpuModule() {
    return (
        <BarComponent
            iconName="cpu-symbolic"
            label={bind(cpuUsage).as((usage) => `${Math.floor(usage * 100)}%`)}
        />
    )
};