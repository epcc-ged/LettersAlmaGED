<?xml version="1.0" encoding="utf-8"?>

<!-- this file: FulPlaceOnHoldShelfLetter.xsl -->
<!-- Historique de mise à jour Campus Condorcet
	 2020-06-09 JCS : adaptation temporaire pour guichet GED (période COVID-19)
	 2020-07-30 JCS : suppression de l'adaptation pour guichet GED
	 2020-03-11 JCS : adaptation temporaire pour 2e confinement (période COVID-19)
	 2021-04-21 JCS : adaptation pour le 3e confinement non-confiné (période COVID-19)
	 2021-06-30 JCS : suppression du lien Evento de prise rdv Covid.
	 2021-11-03 JCS : indication du bureau de prêt de mise à disposition de l'exemplaire
	 2022-12-08 CHA : modification des indications de localisation de mise à disposition
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
<!-- COURRIER ENVOYE A L'USAGER QUAND ON "SCAN IN" UNE RESERVATION
QUI L'ATTEND DESORMAIS EN BUREAU DE CIRC POUR X JOURS -->

<xsl:template match="/">
	<html>
		<head>
			<xsl:call-template name="generalStyle" />
		</head>
		<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<xsl:call-template name="head" /> <!-- header.xsl -->
			<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
			<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->					
			<div class="messageArea">
				<div class="messageBody">
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>@@following_item_requested_on@@ @@can_picked_at@@ 
								<xsl:choose>
									<xsl:when test="notification_data/request/assigned_unit_name = 'Humathèque - Accueil'">
										à l'accueil central de l'Humathèque (rez-de-chaussée).
									</xsl:when>		
									<xsl:when test="notification_data/request/assigned_unit_name = 'Humathèque - Salle de consultation encadrée'">
										à la salle "Archives &amp; Réserve" de l'Humathèque (3e étage).
									</xsl:when>										
									<xsl:otherwise>
										à l'accueil central de l'Humathèque (rez-de-chaussée).
									</xsl:otherwise>								
								</xsl:choose>							
							</td>
						</tr>
						<tr>
							<td>@@note_item_held_until@@
								<xsl:choose>
									<xsl:when test="notification_data/request/work_flow_entity/expiration_date != ''">
										 jusqu'au <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>.
									</xsl:when>
									<xsl:otherwise>
										 pendant deux semaines.
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr>
							<td>Document demandé : 
								<xsl:choose>
									<xsl:when test="notification_data/phys_item_display/title_abcnph != ''">
										<xsl:value-of select="notification_data/phys_item_display/title_abcnph"/>
									</xsl:when>		
									<xsl:otherwise>
										<xsl:call-template name="recordTitle" />
									</xsl:otherwise>								
								</xsl:choose>							
							</td>
						</tr>
						<xsl:if test="notification_data/request/system_notes != ''">
							<tr>
								<td><b>@@notes_affect_loan@@:</b></td>
							</tr>
							<tr>
								<td><xsl:value-of select="notification_data/request/system_notes"/></td>
							</tr>
						</xsl:if>
					</table>
				</div>
			</div> 
			<br />
			<table>
				<tr><td>@@sincerely@@</td></tr>
				<tr><td>@@department@@</td></tr>
			</table>
			
			<xsl:call-template name="lastFooter" /> 
			
		</body>
	</html>
	
</xsl:template>
</xsl:stylesheet>