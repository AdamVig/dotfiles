alsa_monitor.rules = alsa_monitor.rules or {}

table.insert(alsa_monitor.rules, {
  matches = {
    {
      { "device.name", "equals", "alsa_card.usb-CalDigit__Inc._CalDigit_Thunderbolt_3_Audio-00" },
    },
    {
      { "device.name", "equals", "alsa_card.usb-046d_Logitech_BRIO_22514137-03" },
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  }
})

table.insert(alsa_monitor.rules, {
  matches = {
    {
      { "node.name", "equals", "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_5__sink" },
    },
    {
      { "node.name", "equals", "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink" },
    },
    {
      { "node.name", "equals", "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink" },
    },
  },
  apply_properties = {
    ["node.disabled"] = true,
  }
})
