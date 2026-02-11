import { bind } from "astal";
import Network from "gi://AstalNetwork";
import { networkStats } from "../utils/system-stats";

export function Wifi() {
  const network = Network.get_default();
  // Wrap the binding inside a <box>, so Wifi() returns a Widget.
  return (
    <box
      children={
        network.primary == Network.Primary.WIFI ? (
          bind(network, "wifi").as(wifi => {
            return [
              <box
                children={[
                  <image
                    cssClasses={["Wifi"]}
                    iconName={bind(wifi, "iconName")}
                  />,
                  <label label={bind(network, "wired").as(band => band.toString())} />
                ]}
              />
            ];
          })) : (
          bind(network, "wired").as(wifi => {
            return [
              <box
                cssClasses={["Wifi"]}
                children={[
                  <image
                    iconName={bind(wifi, "iconName")}
                  />,
                  <NetworkUsage network={wifi} parenthesize={network instanceof Network.Wired} />,
                ]}
              />
            ];
          }
          ))}
    />
  );
}

function getTotalNetworkThroughput(stats?: { rx: number; tx: number }) {
  if (!stats) {
    return 0;
  } else {
    return stats.rx + stats.tx;
  }
}

function formatNetworkThroughput(value: number, unitIndex: number = 0) {
  // I don't think anyone has exabit internet yet
  const UNITS = ["B", "kB", "MB", "GB", "TB"];

  // never show in bytes, since it's one letter
  unitIndex += 1;
  value /= 1000;

  if (value < 10) {
    return `${value.toFixed(2)} ${UNITS[unitIndex]}/s`;
  } else if (value < 100) {
    return `${value.toFixed(1)} ${UNITS[unitIndex]}/s`;
  } else if (value < 1000) {
    return `${(value / 1000).toFixed(2)} ${UNITS[unitIndex + 1]}/s`;
  } else {
    // do not increase here since it's done at the start of the function
    return formatNetworkThroughput(value, unitIndex);
  }
}

type AnyNetwork = Network.Wifi | Network.Wired;

const NetworkUsage = ({ network, parenthesize }: { network: AnyNetwork; parenthesize: boolean }) => {
  return (
    <box
      child={
        bind(network, "device").as((device) => (
          <label
            label={bind(networkStats).as((stats) => {
              let result = formatNetworkThroughput(getTotalNetworkThroughput(stats[device.interface]));
              if (parenthesize) {
                result = ` (${result})`;
              }
              return result;
            })}
          />
        ))
      }
    />
  );
};