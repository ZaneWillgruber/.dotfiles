import { bind } from "astal";
import { BarComponent } from "./BarComponent";
import { memoryUsage } from "../utils/system-stats";

export function MemoryIndicator() {
    return (
        <BarComponent
            iconName="memory-symbolic"
            label={bind(memoryUsage).as((usage) => `${Math.floor(usage * 100)}%`)}
        />
    );
};