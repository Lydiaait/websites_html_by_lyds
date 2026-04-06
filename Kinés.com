<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kinés.com - Communication Non Verbale et Aphasie</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e6f3ff 100%);
            min-height: 100vh;
            color: #1e3a5f;
        }

        /* Landing Page Overlay */
        .landing-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #0077be, #4aa3ff);
            z-index: 2000;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: all 0.8s ease-in-out;
            opacity: 1;
            visibility: visible;
        }

        .landing-overlay.hide {
            opacity: 0;
            visibility: hidden;
        }

        .landing-content {
            text-align: center;
            color: white;
            padding: 2rem;
            max-width: 800px;
            animation: fadeInUp 1s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .landing-content h1 {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            line-height: 1.3;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.2);
        }

        @media (min-width: 768px) {
            .landing-content h1 {
                font-size: 3.5rem;
            }
        }

        .landing-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.95;
        }

        .btn-commencer {
            background: white;
            color: #0077be;
            border: none;
            padding: 1rem 2.5rem;
            font-size: 1.2rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .btn-commencer:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            background: #f0f9ff;
        }

        /* Main Content - Initially Hidden */
        .main-content {
            display: none;
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .main-content.show {
            display: block;
            opacity: 1;
        }

        /* Header */
        header {
            background: white;
            padding: 1.5rem 2rem;
            box-shadow: 0 4px 15px rgba(0,119,190,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
            border-bottom: 3px solid #4aa3ff;
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .logo h1 {
            font-size: 2rem;
            color: #0077be;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        .logo span {
            color: #1e3a5f;
            font-size: 1rem;
            display: block;
            font-weight: 400;
        }

        nav {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        nav a {
            color: #1e3a5f;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s;
            background: rgba(74, 163, 255, 0.1);
        }

        nav a:hover {
            background: #0077be;
            color: white;
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0,119,190,0.9), rgba(0,119,190,0.7)), url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path fill="white" opacity="0.1" d="M0 0 L100 100 L0 100 Z"/><path fill="white" opacity="0.1" d="M100 0 L0 100 L100 100 Z"/></svg>');
            background-size: cover;
            color: white;
            padding: 4rem 2rem;
            text-align: center;
            margin-bottom: 2rem;
        }

        .hero h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto;
            opacity: 0.95;
        }

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        /* Objectives Section */
        .objectives-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin: 3rem 0;
        }

        .objective-card {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,119,190,0.1);
            transition: all 0.3s;
            border-left: 4px solid #0077be;
            text-align: center;
        }

        .objective-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,119,190,0.2);
        }

        .objective-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        /* Modules Grid */
        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
            margin: 2rem 0 4rem;
        }

        .module-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,119,190,0.1);
            transition: all 0.3s;
            height: fit-content;
            border: 1px solid rgba(74, 163, 255, 0.2);
        }

        .module-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,119,190,0.2);
        }

        .module-header {
            background: linear-gradient(135deg, #0077be, #4aa3ff);
            color: white;
            padding: 1.2rem;
            font-size: 1.3rem;
            font-weight: 600;
        }

        .module-content {
            padding: 1.5rem;
        }

        .module-content ul, .module-content ol {
            padding-left: 1.5rem;
            margin: 0.5rem 0;
        }

        .module-content li {
            margin: 0.5rem 0;
            color: #1e3a5f;
        }

        .badge {
            display: inline-block;
            background: rgba(0,119,190,0.1);
            color: #0077be;
            padding: 0.2rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            border: 1px solid rgba(0,119,190,0.2);
        }

        .technique-item {
            background: #f8fcff;
            padding: 0.8rem;
            margin: 0.5rem 0;
            border-radius: 10px;
            border-left: 3px solid #0077be;
        }

        /* Exercise Section */
        .exercise-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin: 1.5rem 0;
        }

        .exercise-card {
            background: #f8fcff;
            border-radius: 15px;
            padding: 1.2rem;
            transition: all 0.3s;
            border: 1px solid rgba(0,119,190,0.2);
        }

        .exercise-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,119,190,0.1);
        }

        .exercise-card h4 {
            color: #0077be;
            margin-bottom: 0.8rem;
        }

        /* Quiz Section */
        .quiz-container {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            margin: 3rem 0;
            box-shadow: 0 5px 20px rgba(0,119,190,0.1);
        }

        .quiz-question {
            margin: 1.5rem 0;
            padding: 1rem;
            background: #f8fcff;
            border-radius: 15px;
        }

        .quiz-options {
            display: flex;
            gap: 1rem;
            margin-top: 0.5rem;
            flex-wrap: wrap;
        }

        .quiz-option {
            padding: 0.5rem 1.5rem;
            background: white;
            border: 2px solid #4aa3ff;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .quiz-option:hover {
            background: #4aa3ff;
            color: white;
        }

        .quiz-option.correct {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }

        /* Case Studies */
        .case-study {
            background: #f0f9ff;
            border-radius: 15px;
            padding: 1.5rem;
            margin: 1rem 0;
            border-left: 4px solid #0077be;
        }

        .case-study h4 {
            color: #0077be;
            margin-bottom: 0.5rem;
        }

        .solution {
            background: white;
            padding: 1rem;
            border-radius: 10px;
            margin-top: 1rem;
            border: 1px dashed #4aa3ff;
        }

        /* Contact Form */
        .contact-form {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            max-width: 600px;
            margin: 3rem auto;
            box-shadow: 0 5px 20px rgba(0,119,190,0.1);
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group input {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e0f0ff;
            border-radius: 10px;
            font-size: 1rem;
            transition: border 0.3s;
        }

        .form-group input:focus {
            border-color: #0077be;
            outline: none;
        }

        .btn {
            background: #0077be;
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 25px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
        }

        .btn:hover {
            background: #005a8c;
            transform: translateY(-2px);
        }

        /* Footer */
        footer {
            background: #1e3a5f;
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 3rem;
        }

        footer p {
            opacity: 0.9;
        }

        .developer-credit {
            margin-top: 1rem;
            font-size: 0.85rem;
            opacity: 0.7;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                text-align: center;
            }
            
            .hero h2 {
                font-size: 1.8rem;
            }
            
            .modules-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Landing Page -->
    <div class="landing-overlay" id="landingOverlay">
        <div class="landing-content">
            <h1>L'intérêt de la communication non verbale chez les patients aphasiques post-AVC</h1>
            <p>Formation interactive pour professionnels de santé</p>
            <button class="btn-commencer" onclick="startSite()">Commencer</button>
        </div>
    </div>

    <!-- Main Website Content -->
    <div class="main-content" id="mainContent">
        <header>
            <div class="header-content">
                <div class="logo">
                    <h1>Kinés.com</h1>
                    <span>Formation en communication non verbale</span>
                </div>
                <nav>
                    <a href="#accueil">Accueil</a>
                    <a href="#modules">Modules</a>
                    <a href="#exercices">Exercices</a>
                    <a href="#quiz">Quiz</a>
                    <a href="#cas-pratiques">Cas pratiques</a>
                    <a href="#contact">Contact</a>
                </nav>
            </div>
        </header>

        <section class="hero" id="accueil">
            <h2>Communication non verbale et aphasie post-AVC</h2>
            <p>Formation essentielle pour les professionnels de santé - Améliorez la prise en charge de vos patients aphasiques</p>
        </section>

        <div class="container">
            <!-- Objectives Cards -->
            <div class="objectives-grid">
                <div class="objective-card">
                    <div class="objective-icon">🧠</div>
                    <h3>Comprendre l'aphasie</h3>
                    <p>Maîtrisez les différents types et leurs impacts</p>
                </div>
                <div class="objective-card">
                    <div class="objective-icon">👐</div>
                    <h3>Communication non verbale</h3>
                    <p>Développez vos compétences en communication silencieuse</p>
                </div>
                <div class="objective-card">
                    <div class="objective-icon">💪</div>
                    <h3>Prise en charge kiné</h3>
                    <p>Techniques adaptées aux patients aphasiques</p>
                </div>
                <div class="objective-card">
                    <div class="objective-icon">🤝</div>
                    <h3>Relation soignant-soigné</h3>
                    <p>Renforcez le lien thérapeutique</p>
                </div>
            </div>

            <!-- Modules Section -->
            <h2 style="color: #0077be; margin: 2rem 0 1rem; font-size: 2rem;" id="modules">📚 Modules de formation</h2>
            
            <div class="modules-grid">
                <!-- Module 1 -->
                <div class="module-card">
                    <div class="module-header">Module 1: L'aphasie post-AVC</div>
                    <div class="module-content">
                        <p><strong>Définition:</strong> Trouble du langage causé par une lésion cérébrale, souvent liée à un AVC.</p>
                        <p><strong>Types:</strong></p>
                        <ul>
                            <li><span class="badge">Broca</span> Difficulté à parler</li>
                            <li><span class="badge">Wernicke</span> Difficulté à comprendre</li>
                            <li><span class="badge">Globale</span> Atteinte sévère</li>
                        </ul>
                        <p><strong>Conséquences:</strong> Difficulté de communication, isolement social, frustration</p>
                    </div>
                </div>

                <!-- Module 2 -->
                <div class="module-card">
                    <div class="module-header">Module 2: Communication non verbale</div>
                    <div class="module-content">
                        <p><strong>Définition:</strong> Ensemble des moyens de communication sans parole.</p>
                        <p><strong>Types:</strong></p>
                        <ul>
                            <li>👐 Gestes</li>
                            <li>👀 Regard</li>
                            <li>😊 Expressions faciales</li>
                            <li>🧍 Posture</li>
                            <li>🤲 Toucher thérapeutique</li>
                        </ul>
                    </div>
                </div>

                <!-- Module 3 -->
                <div class="module-card">
                    <div class="module-header">Module 3: Importance en kinésithérapie</div>
                    <div class="module-content">
                        <ul>
                            <li>✅ Facilite la compréhension</li>
                            <li>✅ Réduit l'anxiété</li>
                            <li>✅ Améliore la participation</li>
                            <li>✅ Renforce la relation thérapeutique</li>
                        </ul>
                    </div>
                </div>

                <!-- Module 4: Techniques Avancées -->
                <div class="module-card">
                    <div class="module-header">Module 4: Techniques avancées de communication non verbale</div>
                    <div class="module-content">
                        <div class="technique-item"><strong>1. La synchronisation (mirroring)</strong> - Imiter doucement les gestes ou la posture du patient → crée un sentiment de confiance</div>
                        <div class="technique-item"><strong>2. Supports visuels</strong> - Images, pictogrammes, cartes → facilite la compréhension, réduit la frustration</div>
                        <div class="technique-item"><strong>3. Démonstration guidée</strong> - Combiner démonstration + guidage manuel → très efficace en kinésithérapie</div>
                        <div class="technique-item"><strong>4. Le pointage (indexation)</strong> - Montrer avec le doigt un objet, une partie du corps → simplifie les consignes</div>
                        <div class="technique-item"><strong>5. Rythme et lenteur des gestes</strong> - Gestes lents, clairs, répétitifs → améliore la compréhension</div>
                        <div class="technique-item"><strong>6. Validation non verbale</strong> - Hochement de tête, sourire, regard attentif → encourage le patient</div>
                        <div class="technique-item"><strong>7. Utilisation de l'espace (proxémie)</strong> - Adapter la distance → proche = rassurant, trop proche = stressant</div>
                        <div class="technique-item"><strong>8. Toucher fonctionnel spécifique</strong> - Toucher pour guider un mouvement, corriger une posture → essentiel en kiné</div>
                        <div class="technique-item"><strong>9. Répétition multimodale</strong> - Répéter la même info avec geste, regard, démonstration → renforce la compréhension</div>
                        <div class="technique-item"><strong>10. Silence thérapeutique</strong> - Laisser du temps au patient → réduit la pression, favorise la réponse</div>
                        <div class="technique-item"><strong>11. Reformulation gestuelle</strong> - Refaire le geste du patient pour montrer que tu as compris → crée une interaction</div>
                        <div class="technique-item"><strong>12. Signaux d'encouragement</strong> - Pouce en l'air, sourire, applaudissement léger → motive le patient</div>
                        <div class="technique-item"><strong>13. Adaptation émotionnelle</strong> - Lire les émotions (stress, fatigue, frustration) → adapter ton comportement</div>
                        <div class="technique-item"><strong>14. Regard directionnel</strong> - Regarder vers un objet ou une direction → aide à orienter le patient</div>
                        <div class="technique-item"><strong>15. Ancrage gestuel</strong> - Associer un geste à une action → le patient mémorise plus facilement</div>
                    </div>
                </div>

                <!-- Module 5 -->
                <div class="module-card">
                    <div class="module-header">Module 5: Difficultés</div>
                    <div class="module-content">
                        <ul>
                            <li>❌ Incompréhension</li>
                            <li>❌ Stress</li>
                            <li>❌ Manque de formation</li>
                        </ul>
                    </div>
                </div>

                <!-- Module 6 -->
                <div class="module-card">
                    <div class="module-header">Module 6: Résultats attendus</div>
                    <div class="module-content">
                        <ul>
                            <li>📈 Amélioration de la communication</li>
                            <li>📈 Participation active</li>
                            <li>📈 Meilleure récupération</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Prise en charge Kinésithérapie Section with Exercises -->
            <h2 style="color: #0077be; margin: 2rem 0 1rem; font-size: 2rem;" id="exercices">🏋️‍♂️ Prise en charge kinésithérapie - Exercices pratiques</h2>
            <p style="margin-bottom: 1rem;">La rééducation de l'aphasie post-AVC repose sur des exercices de stimulation du langage pour améliorer progressivement les capacités de communication du patient.</p>
            
            <div class="exercise-grid">
                <div class="exercise-card">
                    <h4>1. Motricité bucco-faciale</h4>
                    <p>Renforce les muscles utilisés pour parler.</p>
                    <ul style="margin-top: 0.5rem; padding-left: 1.2rem;">
                        <li>Tirer la langue puis la rentrer</li>
                        <li>Bouger la langue à droite et à gauche</li>
                        <li>Gonfler les joues puis relâcher</li>
                        <li>Serrer et relâcher les lèvres</li>
                    </ul>
                </div>

                <div class="exercise-card">
                    <h4>2. Répétition de sons</h4>
                    <p>Le thérapeute prononce un son, le patient répète.</p>
                    <ul style="margin-top: 0.5rem; padding-left: 1.2rem;">
                        <li>Voyelles : a – e – i – o – u</li>
                        <li>Syllabes : ma – pa – ba – ta</li>
                    </ul>
                </div>

                <div class="exercise-card">
                    <h4>3. Dénomination</h4>
                    <p>Nommer un objet ou une image.</p>
                    <ul style="margin-top: 0.5rem; padding-left: 1.2rem;">
                        <li>Montrer une image (pomme, chaise, verre)</li>
                        <li>Demander au patient de dire le nom</li>
                    </ul>
                    <p style="margin-top: 0.5rem; font-style: italic;">Objectif : améliorer l'accès au vocabulaire</p>
                </div>

                <div class="exercise-card">
                    <h4>4. Compréhension</h4>
                    <p>Le thérapeute donne une consigne simple.</p>
                    <ul style="margin-top: 0.5rem; padding-left: 1.2rem;">
                        <li>« Lève la main »</li>
                        <li>« Ferme les yeux »</li>
                        <li>« Touche ton nez »</li>
                    </ul>
                </div>

                <div class="exercise-card">
                    <h4>5. Geste et parole</h4>
                    <p>Associer geste + mot.</p>
                    <ul style="margin-top: 0.5rem; padding-left: 1.2rem;">
                        <li>Montrer « boire » avec le geste d'un verre</li>
                        <li>Demander au patient de répéter le mot</li>
                    </ul>
                </div>

                <div class="exercise-card">
                    <h4>6. Respiration et phonation</h4>
                    <ul style="margin-top: 0.5rem; padding-left: 1.2rem;">
                        <li>Inspirer profondément</li>
                        <li>Expirer en faisant "aaa" ou "ooo"</li>
                    </ul>
                    <p style="margin-top: 0.5rem; font-style: italic;">Objectif : améliorer le contrôle de la voix et de la parole</p>
                </div>
            </div>

            <!-- Case Studies -->
            <h2 style="color: #0077be; margin: 2rem 0 1rem;" id="cas-pratiques">🏥 Cas pratiques</h2>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem;">
                <div class="case-study">
                    <h4>Cas 1: Patient ne comprend pas les consignes</h4>
                    <p>Patient aphasique de 65 ans, difficulté à suivre les instructions verbales.</p>
                    <div class="solution">
                        <strong>Solution:</strong> Utiliser gestes simples + démonstration pratique. Maintenir contact visuel.
                    </div>
                </div>

                <div class="case-study">
                    <h4>Cas 2: Patient anxieux</h4>
                    <p>Patiente de 58 ans, très anxieuse, pleure facilement.</p>
                    <div class="solution">
                        <strong>Solution:</strong> Sourire rassurant + contact visuel chaleureux + toucher thérapeutique sur l'épaule.
                    </div>
                </div>
            </div>

            <!-- Quiz Section -->
            <div class="quiz-container" id="quiz">
                <h2 style="color: #0077be; margin-bottom: 1.5rem;">📝 Quiz d'évaluation</h2>
                
                <div class="quiz-question">
                    <p><strong>1. La communication non verbale inclut :</strong></p>
                    <div class="quiz-options">
                        <span class="quiz-option" onclick="this.classList.toggle('correct')">a) Parole</span>
                        <span class="quiz-option correct" onclick="this.classList.toggle('correct')">b) Gestes ✓</span>
                        <span class="quiz-option" onclick="this.classList.toggle('correct')">c) Écriture</span>
                    </div>
                    <p style="color: #28a745; margin-top: 0.5rem; font-size: 0.9rem;">(Cliquez sur la bonne réponse - elle deviendra verte)</p>
                </div>

                <div class="quiz-question">
                    <p><strong>2. L'aphasie est :</strong></p>
                    <div class="quiz-options">
                        <span class="quiz-option" onclick="this.classList.toggle('correct')">a) Trouble moteur</span>
                        <span class="quiz-option correct" onclick="this.classList.toggle('correct')">b) Trouble du langage ✓</span>
                    </div>
                </div>

                <div class="quiz-question">
                    <p><strong>3. Le mirroring (synchronisation) permet de :</strong></p>
                    <div class="quiz-options">
                        <span class="quiz-option correct" onclick="this.classList.toggle('correct')">a) Créer un sentiment de confiance ✓</span>
                        <span class="quiz-option" onclick="this.classList.toggle('correct')">b) Accélérer les exercices</span>
                        <span class="quiz-option" onclick="this.classList.toggle('correct')">c) Éviter le contact visuel</span>
                    </div>
                </div>
            </div>

            <!-- Conclusion -->
            <div style="background: white; border-radius: 20px; padding: 2rem; margin: 3rem 0; text-align: center; border-left: 4px solid #0077be;">
                <h2 style="color: #0077be;">🎯 Conclusion</h2>
                <p style="font-size: 1.1rem; max-width: 800px; margin: 1rem auto;">
                    La communication non verbale est essentielle dans la prise en charge des patients aphasiques post-AVC. 
                    Elle améliore la qualité des soins et la relation thérapeutique.
                </p>
            </div>

            <!-- Contact Form -->
            <div class="contact-form" id="contact">
                <h2 style="color: #0077be; margin-bottom: 1.5rem;">📧 Contactez-nous</h2>
                <form onsubmit="event.preventDefault(); alert('Merci! Nous vous contacterons bientôt.');">
                    <div class="form-group">
                        <input type="text" placeholder="Votre nom complet" required>
                    </div>
                    <div class="form-group">
                        <input type="email" placeholder="Votre email" required>
                    </div>
                    <button type="submit" class="btn">Envoyer</button>
                </form>
            </div>
        </div>

        <footer>
            <p>© 2026 Kinés.com - Formation en communication non verbale pour professionnels de santé</p>
            <p style="margin-top: 0.5rem;"Elaborée pour<strong>Tahir Ahlem ET Ghezzaz Aya</strong> - 2026</p>
            <p style="margin-top: 0.5rem; font-size: 0.85rem;">Tous droits réservés</p>
        </footer>
    </div>

    <script>
        function startSite() {
            const landing = document.getElementById('landingOverlay');
            const mainContent = document.getElementById('mainContent');
            
            landing.classList.add('hide');
            mainContent.classList.add('show');
            
            setTimeout(() => {
                window.scrollTo(0, 0);
            }, 100);
        }
    </script>
</body>
</html>
