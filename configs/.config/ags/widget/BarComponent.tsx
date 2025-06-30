import { Binding } from "astal";

type BarComponentProps = {
    iconName: Binding<string> | string;
    label: Binding<string> | string;
}

export function BarComponent({ iconName, label }: BarComponentProps) {
    return (
        <box
            cssClasses={["BarComponent"]}
            children={[
                <image
                    iconName={iconName}
                />,
                <label
                    label={label}
                />
            ]}
        />
    )
}