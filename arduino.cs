using Godot;
using System;
using System.IO.Ports;

public partial class arduino : Node
{
	SerialPort serialPort;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		serialPort = new SerialPort();
		serialPort.PortName = "COM3";
		serialPort.BaudRate = 9600;
		serialPort.Open();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (!serialPort.IsOpen) return;

		// Obtener la raíz de la escena
		Node rootNode = GetTree().Root;

		// Buscar el nodo "GLOBAL" relativo a la raíz
		Node globalNode = rootNode.GetNode("GLOBAL");

		// Verificar si el nodo global se encuentra
		if (globalNode != null)
		{
			if (serialPort.BytesToRead > 0)
			{
				string serialMessage = serialPort.ReadLine();
				if (!string.IsNullOrEmpty(serialMessage))
				{
					globalNode.Call("modificar_ultimo_dardo", serialMessage);
				}
			}
		}
		else
		{
			GD.Print("No se encontró el nodo GLOBAL.");
		}
	}
}
