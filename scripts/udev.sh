#!/usr/bin/env bash
# udev: stop the Logitech LIGHTSPEED mouse receiver (046d:c547) from waking
# the system out of suspend. Matched by ID, so any USB port and either machine
# works; no-op where the receiver isn't plugged in. Keyboard wake is untouched.
set -euo pipefail

rule=/etc/udev/rules.d/90-mouse-no-wakeup.rules
vendor=046d product=c547
content="ACTION==\"add\", SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$vendor\", ATTR{idProduct}==\"$product\", ATTR{power/wakeup}=\"disabled\""

if [[ -f $rule && "$(<"$rule")" == "$content" ]]; then
	echo "udev: $rule already up to date"
else
	printf '%s\n' "$content" | sudo tee "$rule" >/dev/null
	sudo udevadm control --reload
	echo "udev: wrote $rule"
fi

# Apply now, without replugging the receiver.
sudo udevadm trigger --action=add --subsystem-match=usb \
	--attr-match=idVendor=$vendor --attr-match=idProduct=$product
