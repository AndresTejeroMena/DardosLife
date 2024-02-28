using Godot;
using System;
using System.IO.Ports;

public partial class arduino : Node
{
	SerialPort serialPort;

	// Variables para controlar el estado de lectura del puerto serie
	bool isReadingSerial = true;
	string selectedPort = "COM3"; // Puerto serie por defecto

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		OpenSerialPort(selectedPort);
	}

	// Función para abrir el puerto serie
	void OpenSerialPort(string portName)
	{
		try
		{
			serialPort = new SerialPort();
			serialPort.PortName = portName;
			serialPort.BaudRate = 9600;
			serialPort.DtrEnable = true;
			serialPort.RtsEnable = true;
			serialPort.Open();
		}
		catch (Exception e)
		{
			GD.Print("Error al abrir el puerto serie: " + e.Message);
		}
	}

	// Función para cerrar el puerto serie
	void CloseSerialPort()
	{
		if (serialPort != null && serialPort.IsOpen)
		{
			serialPort.Close();
		}
	}

	// Función para cambiar el puerto serie
	void ChangeSerialPort(string newPort)
	{
		if (serialPort != null && serialPort.IsOpen)
		{
			CloseSerialPort();
		}
		selectedPort = newPort;
		OpenSerialPort(selectedPort);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (!isReadingSerial || serialPort == null || !serialPort.IsOpen)
			return;

		Node rootNode = GetTree().Root;
		Node globalNode = rootNode.GetNode("GLOBAL");

		if (globalNode != null)
		{
			if (serialPort.BytesToRead > 0)
			{
				GD.Print("Se ha leido un mensaje");
				string serialMessage = serialPort.ReadLine();
				if (!string.IsNullOrEmpty(serialMessage))
				{
					GD.Print("Se ha enviado un mensaje");
					globalNode.Call("modificar_ultimo_dardo", serialMessage);
				}
			}
		}
		else
		{
			GD.Print("No se encontró el nodo GLOBAL.");
		}
	}

	// Función para detener la lectura del puerto serie
	public void StopReadingSerial()
	{
		isReadingSerial = false;
		CloseSerialPort();
	}

	// Función para reanudar la lectura del puerto serie y cambiar el puerto si es necesario
	public void StartReadingSerial(string newPort = null)
	{
		isReadingSerial = true;
		if (newPort != null && selectedPort != newPort)
		{
			ChangeSerialPort(newPort);
		}
	}
}
